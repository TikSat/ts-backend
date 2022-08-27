class Category::Representer < Base::Representer
  property :id
  property :name
  property :desc
  property :parent_id
  property :parent_slug, getter: ->(represented:, **) { represented.parent&.slug }
  property :slug
  property :image_small, getter: ->(represented:, **) { represented.image_url(:small) }

  collection :subcategories, decorator: Category::Representer
  collection :custom_fields, decorator: CustomField::Representer
end
