class CategoryRepresenter < ApplicationRepresenter
  property :id
  property :name
  property :desc
  property :parent_id

  property :created_at
  property :updated_at

  collection :subcategories, decorator: CategoryRepresenter
end
