class ListingRepresenter < ApplicationRepresenter
  property :id
  property :title
  property :desc
  property :field_values
  property :expires_at
  property :author, decorator: ->(decorator:, input:, **) { decorator.representer_for(input) }
  property :category

  collection :custom_fields, decorator: CustomFieldRepresenter

  def representer_for(object)
    "#{object.class.name}Representer".constantize
  end
end
