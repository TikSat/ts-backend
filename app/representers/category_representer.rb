class CategoryRepresenter < ApplicationRepresenter
  property :id
  property :name
  property :desc
  property :parent_id
  property :slug

  collection :subcategories, decorator: CategoryRepresenter
end
