FactoryBot.reload

10.times do
  cat = FactoryBot.create(:category, :with_custom_fields, :with_listings)
  FactoryBot.create_list(:category, 2, :with_custom_fields, :with_listings,  parent_id: cat.id)
end

FactoryBot.create(:user_with_profiles)
