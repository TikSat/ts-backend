class Listing::Form < Base::Form
  property :category_id
  property :profile_id
  property :title
  property :images_attributes, virtual: true

  validation name: :default do
    params do
      required(:category_id).value(:string, :uuid_v4?)
      required(:profile_id).value(:string, :uuid_v4?)
      required(:title).value(:string)
    end
  end
end
