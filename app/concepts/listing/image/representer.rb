class Listing::Image::Representer < Base::Representer
  property :id
  property :image_extra_small, getter: ->(represented:, **) { represented.image_url(:xs) }
  property :image_small, getter: ->(represented:, **) { represented.image_url(:sm) }
  property :image_medium, getter: ->(represented:, **) { represented.image_url(:md) }
  property :image_large, getter: ->(represented:, **) { represented.image_url(:lg) }
end
