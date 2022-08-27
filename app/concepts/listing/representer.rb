class Listing::Representer < Base::Representer
  property :id
  property :title
  property :desc
  property :field_values
  property :slug
  property :expires_at
  property :author, decorator: ->(decorator:, input:, **) { decorator.representer_for(input) }
  property :category

  collection :custom_fields, decorator: CustomField::Representer

  def representer_for(object)
    "#{object.class.name}::Representer".constantize
  end
end
