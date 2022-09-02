FactoryBot.reload

require Rails.root.join('db/seeds/custom_fields').to_s
require Rails.root.join('db/seeds/categories').to_s

FactoryBot.create(:user_with_profiles)

1000.times do
  category = Category.children.sample
  author = Profile.all.sample
  FactoryBot.create(:listing, category:, author:,
                    image_remote_url: 'https://picsum.photos/600/450',
                    images_attributes:
                      [
                        { image_remote_url: 'https://picsum.photos/600/450' },
                        { image_remote_url: 'https://picsum.photos/600/450' }
                      ]
                    )
rescue StandardError => e
  pp e
  next
end

puts 'DB seeded'
