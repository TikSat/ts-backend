# == Schema Information
#
# Table name: listings
#
#  id           :uuid             not null, primary key
#  active       :boolean          default(TRUE), not null
#  desc         :text
#  expires_at   :datetime
#  field_values :jsonb
#  image_data   :jsonb
#  price        :float            default(0.0)
#  slug         :string
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  category_id  :uuid
#  profile_id   :uuid
#
# Indexes
#
#  idx_field_values                         ((((field_values ->> 'field_id'::text))::uuid))
#  index_listings_on_category_id            (category_id)
#  index_listings_on_category_id_and_price  (category_id,price)
#  index_listings_on_profile_id             (profile_id)
#  index_listings_on_slug                   (slug) UNIQUE
#  index_listings_on_title                  (title)
#
class Listing < ApplicationRecord
  include ListingImageUploader::Attachment.new(:image)
  include PgSearch::Model

  belongs_to :category, counter_cache: true
  belongs_to :author, class_name: 'Profile', foreign_key: :profile_id
  has_many :custom_fields, through: :category
  has_many :images, class_name: 'Listing::Image', dependent: :destroy

  accepts_nested_attributes_for :images

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  before_create :set_expires_at

  store_accessor :field_values

  pg_search_scope :search_by_title,
                  against: :title,
                  using: {
                    tsearch: { prefix: true }
                  }

  pg_search_scope :search_by_desc,
                  against: :desc

  def slug_candidates
    slugs = [:title]
    slugs << [:title, category.name]
    slugs
  end

  private

  def set_expires_at
    self.expires_at = 1.week.from_now
  end
end
