# == Schema Information
#
# Table name: categories
#
#  id         :uuid             not null, primary key
#  desc       :text
#  image_data :jsonb
#  name       :string
#  slug       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :uuid
#
FactoryBot.define do
  factory :category do
    name { Faker::Book.title }
    desc { Faker::Book.genre }
  end
end
