class Category < ApplicationRecord
  include CategoryImageUploader::Attachment(:image)
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :parent, class_name: 'Category', optional: true
  has_many :subcategories, class_name: 'Category', foreign_key: :parent_id

  scope :root, -> { order(created_at: :desc).where(parent_id: nil) }
end
