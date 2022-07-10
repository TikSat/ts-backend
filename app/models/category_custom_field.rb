class CategoryCustomField < ApplicationRecord
  belongs_to :category
  belongs_to :custom_field
end
