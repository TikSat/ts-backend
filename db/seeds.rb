FactoryBot.reload

require Rails.root.join('db/seeds/custom_fields').to_s
require Rails.root.join('db/seeds/categories').to_s

FactoryBot.create(:user_with_profiles)

1000.times do
  category = Category.children.sample
  author = Profile.all.sample
  FactoryBot.create(:listing, category:, author:)
end

puts 'DB seeded'
