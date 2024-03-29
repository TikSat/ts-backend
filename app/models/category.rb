# == Schema Information
#
# Table name: categories
#
#  id             :uuid             not null, primary key
#  desc           :text
#  image_data     :jsonb
#  listings_count :integer          default(0)
#  name           :string
#  slug           :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  parent_id      :uuid
#
# Indexes
#
#  index_categories_on_slug  (slug) UNIQUE
#
class Category < ApplicationRecord
  include CategoryImageUploader::Attachment.new(:image)
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  belongs_to :parent, class_name: 'Category', optional: true
  has_many :subcategories, class_name: 'Category', foreign_key: :parent_id, dependent: :restrict_with_error
  has_many :category_custom_fields
  has_many :custom_fields, through: :category_custom_fields
  has_many :listings, dependent: :restrict_with_error

  validates :name, :slug, presence: true, uniqueness: true

  scope :root, -> { where(parent_id: nil) }
  scope :children, -> { where('parent_id IS NOT NULL') }

  # rubocop:disable Style/RedundantSelf
  def total_listings_count
    subcategories.any? ? child_listings_count : self.listings_count
  end
  # rubocop:enable Style/RedundantSelf

  def child_listings_count
    children.pluck(:listings_count).sum
  end

  def slug_candidates
    slugs = [:name]
    slugs << [:name, parent.name] if parent.present?
    slugs
  end

  # TODO: move to fetcher class
  # self custom fields + parents custom fields
  def all_custom_fields
    query =
      <<~SQL
        WITH RECURSIVE
          category_tree AS (
            SELECT *
            FROM categories
            WHERE categories.id = :category_id

            UNION ALL

            SELECT categories.*
            FROM categories, category_tree
            WHERE categories.id = category_tree.parent_id
          ),
          fields AS (
            SELECT cf.*
            FROM custom_fields cf
            INNER JOIN category_custom_fields ccf ON ccf.custom_field_id = cf.id
            INNER JOIN category_tree c ON c.id = ccf.category_id
          )

        SELECT DISTINCT ON (fields.id) * from fields
      SQL

    Rails.cache.fetch("#{cache_key_with_version}/custom_fields", expires_in: 12.hours) do
      CustomField.find_by_sql([query, { category_id: id }])
    end
  end

  def parents
    Rails.cache.fetch("#{cache_key_with_version}/parents", expires_in: 12.hours) do
      Category.find_by_sql([parents_tree_sql, { parent_category_id: parent_id, category_id: id }])
    end
  end

  def children
    Rails.cache.fetch("#{cache_key_with_version}/children", expires_in: 12.hours) do
      Category.find_by_sql([children_tree_sql, { category_id: id }])
    end
  end

  def parents_tree_sql
    <<~SQL
      WITH RECURSIVE category_tree AS (
        SELECT *
        FROM categories
        WHERE categories.id = :category_id

        UNION ALL

        SELECT categories.*
        FROM categories, category_tree
        WHERE categories.id = category_tree.parent_id
      )

      SELECT * from category_tree
    SQL
  end

  def children_tree_sql
    <<~SQL
      WITH RECURSIVE category_tree AS (
        SELECT *
        FROM categories
        WHERE categories.id = :category_id

        UNION ALL

        SELECT categories.*
        FROM categories, category_tree
        WHERE categories.parent_id = category_tree.id
      )

      SELECT * from category_tree WHERE category_tree.id != :category_id
    SQL
  end
end
