class CategorySerializer < ApplicationSerializer
  attributes :name, :desc
  belongs_to :parent, serializer: CategorySerializer
  has_many :subcategories, serializer: CategorySerializer
end
