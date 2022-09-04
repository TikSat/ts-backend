class Category::Representer < Base::Representer
  property :id
  property :name
  property :desc
  property :parent_id
  property :parent_slug, getter: ->(represented:, **) { represented.parent&.slug }
  property :slug
  property :image_extra_small, getter: ->(represented:, **) { represented.image_url(:xs) }
  property :image_small, getter: ->(represented:, **) { represented.image_url(:sm) }
  property :image_medium, getter: ->(represented:, **) { represented.image_url(:md) }
  property :image_large, getter: ->(represented:, **) { represented.image_url(:lg) }
  property :listings_count

  collection :subcategories, decorator: Category::Representer
  collection :custom_fields, decorator: CustomField::Representer
end
