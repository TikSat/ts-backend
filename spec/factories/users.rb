# == Schema Information
#
# Table name: users
#
#  id                       :uuid             not null, primary key
#  allowed_ips              :inet             default([]), is an Array
#  confirmation_email_token :string
#  confirmation_phone_token :string
#  confirmed_email_at       :datetime
#  confirmed_phone_at       :datetime
#  current_login_at         :string
#  current_login_country    :string
#  current_login_ip         :inet
#  email                    :string
#  last_login_at            :datetime
#  last_login_country       :string
#  last_login_ip            :inet
#  login_count              :integer
#  opt_required             :boolean          default(FALSE)
#  password_digest          :string
#  phone                    :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_users_on_email            (email) UNIQUE
#  index_users_on_email_and_phone  (email,phone) UNIQUE
#  index_users_on_phone            (phone) UNIQUE
#
FactoryBot.define do
  factory :user do
    email { Faker::Internet.username + Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    password { SecureRandom.uuid }
  end

  factory :user_with_profiles, parent: :user do
    after(:create) do |user|
      profiles = []
      profiles << FactoryBot.create(:profile, profile_type: 'Profile::User')
      profiles << FactoryBot.create(:profile, profile_type: 'Profile::Company')
      profiles << FactoryBot.create(:profile, profile_type: 'Profile::Admin')
      user.profiles << profiles
      user.user_profiles.last.update!(current: true)
    end
  end
end
