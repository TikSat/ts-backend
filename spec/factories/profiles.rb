# == Schema Information
#
# Table name: profiles
#
#  id           :uuid             not null, primary key
#  address_1    :string
#  address_2    :string
#  avatar_data  :jsonb
#  city         :string
#  country      :string
#  cover_data   :jsonb
#  currency     :string
#  first_name   :string
#  gender       :string
#  language     :string
#  last_name    :string
#  middle_name  :string
#  name         :string
#  postal_code  :string
#  profile_type :string           default("Profile::User")
#  slug         :string
#  time_zone    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_profiles_on_slug  (slug) UNIQUE
#
FactoryBot.define do
  factory :profile do
    first_name { Faker::Superhero.name }
    last_name { Faker::Superhero.power }
    name { Faker::Company.name }
  end
end
