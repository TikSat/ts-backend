FactoryBot.define do
  factory :category do
    name { Faker::Book.title }
    desc { Faker::Book.genre }
  end
end
