# == Schema Information
#
# Table name: categories
#
#  id             :uuid             not null, primary key
#  desc           :text
#  image_data     :jsonb
#  listings_count :integer          default(0)
#  name           :string
#  slug           :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  parent_id      :uuid
#
# Indexes
#
#  index_categories_on_slug  (slug) UNIQUE
#
FactoryBot.define do
  factory :category do
    name { Faker::Book.title }
    desc { Faker::Book.genre }

    trait :with_custom_fields do
      after(:create) do |category|
        fields = []
        fields << FactoryBot.create(:text_field)
        fields << FactoryBot.create(:numeric_field)
        fields << FactoryBot.create(:checkbox_field)
        fields << FactoryBot.create(:date_field)
        category.custom_fields << fields
      end
    end

    trait :with_listings do
      after(:create) do |category|
        create_list(:listing, 10, :with_custom_fields_values, category_id: category.id)
      end
    end
  end
end
