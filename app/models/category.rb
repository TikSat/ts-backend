class Category < ApplicationRecord
  include CategoryImageUploader::Attachment(:image)

  belongs_to :parent, class_name: 'Category', optional: true
  has_many :subcategories, class_name: 'Category', foreign_key: :parent_id

  scope :root, -> { where(parent_id: nil) }
end
