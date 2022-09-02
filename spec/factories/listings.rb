# == Schema Information
#
# Table name: listings
#
#  id           :uuid             not null, primary key
#  active       :boolean          default(TRUE), not null
#  desc         :text
#  expires_at   :datetime
#  field_values :jsonb
#  image_data   :jsonb
#  price        :float            default(0.0)
#  slug         :string
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  category_id  :uuid
#  profile_id   :uuid
#
# Indexes
#
#  idx_field_values                         ((((field_values ->> 'field_id'::text))::uuid))
#  index_listings_on_category_id            (category_id)
#  index_listings_on_category_id_and_price  (category_id,price)
#  index_listings_on_profile_id             (profile_id)
#  index_listings_on_slug                   (slug) UNIQUE
#  index_listings_on_title                  (title)
#
FactoryBot.define do
  factory :listing do
    association :author, factory: :profile
    association :category, factory: :category
    desc { Faker::ChuckNorris.fact }
    title { Faker::Game.title }
    price { rand(1_000_000_000) }

    after(:build) do |listing|
      listing.category.all_custom_fields.each do |field|
        listing.field_values[field.id] = rand(100)
      end
    end
  end
end
