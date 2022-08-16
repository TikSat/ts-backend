class Category::Representer < Base::Representer
  property :id
  property :name
  property :desc
  property :parent_id
  property :slug
  property :image_small, getter: ->(represented:, **) { represented.image_url(:small) }

  # collection :subcategories, decorator: CategoryRepresenter
  # collection :custom_fields, decorator: CustomFieldRepresenter
end
