FactoryBot.reload

time_start = Time.now
puts "Seed started at #{time_start.strftime('%H:%M:%S %:z')}"

require Rails.root.join('db/seeds/custom_fields').to_s
puts "Categories seeded at #{Time.now.strftime('%H:%M:%S %:z')}"
require Rails.root.join('db/seeds/categories').to_s
puts "Custom fields seeded at #{Time.now.strftime('%H:%M:%S %:z')}"

FactoryBot.create_list(:user_with_profiles, 10)
puts "Profiles seeded at #{Time.now.strftime('%H:%M:%S %:z')}"
fibers = []

(ENV['RAILS_MAX_THREADS'] || 5).to_i.times do |thr_num|
  fibers << Thread.new do
    5.times do |i|
      category = Category.children.sample
      author = Profile.all.sample
      FactoryBot.create(:listing, category:, author:,
                                  image_remote_url: 'https://picsum.photos/600/450',
                                  images_attributes: [
                                    { image_remote_url: 'https://picsum.photos/600/450' },
                                    { image_remote_url: 'https://picsum.photos/600/450' }
                                  ])
      puts "Listing ##{i} of 1000 created in thread #{thr_num}"
    rescue StandardError => e
      pp e
      next
    end
  end
end

fibers.each do |f|
  f.join
rescue StandardError => e
  pp e
end

time_end = Time.now
diff = (time_end - time_start)

puts "DB seeded in #{diff} s. Listings created: #{Listing.count}"
