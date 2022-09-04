class Listing::Representer < Base::Representer
  property :id
  property :title
  property :desc
  property :slug
  property :expires_at
  property :author, decorator: ->(decorator:, input:, **) { decorator.representer_for(input) }
  property :category, decorator: Category::Representer
  property :fields, exec_context: :decorator
  property :image_extra_small, getter: ->(represented:, **) { represented.image_url(:xs) }
  property :image_small, getter: ->(represented:, **) { represented.image_url(:sm) }
  property :image_medium, getter: ->(represented:, **) { represented.image_url(:md) }
  property :image_large, getter: ->(represented:, **) { represented.image_url(:lg) }
  property :price
  property :created_at
  property :updated_at
  collection :images, decorator: Listing::Image::Representer

  def representer_for(object)
    "#{object.class.name}::Representer".constantize
  end

  def fields
    represented.field_values.map do |id, value|
      { name: CustomField.find(id).name, value: }
    end
  end
end
