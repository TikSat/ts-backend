class CustomField < ApplicationRecord
  self.inheritance_column = 'custom_field_type'
  has_many :category_custom_fields
  has_many :categories, through: :category_custom_fields
end
