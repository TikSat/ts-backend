FactoryBot.reload

# FIXME: Clear DB on seeding

2.times do
  cat = FactoryBot.create(:category, :with_custom_fields, :with_listings)
  FactoryBot.create_list(:category, 2, :with_custom_fields, :with_listings, parent_id: cat.id)

  Category.all.each do |category|
    FactoryBot.create_list(:listing, 3, :with_custom_fields_values, category:)
  end
end

listings = []

1000.times do
  cat_id = Category.ids.sample
  listings << FactoryBot.attributes_for(:listing, :with_custom_fields_values, category_id: cat_id)
end

Listing.upsert_all(listings)

FactoryBot.create(:user_with_profiles)

puts 'DB seeded'
