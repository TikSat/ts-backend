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
class User < ApplicationRecord
  has_secure_password
  api_guard_associations refresh_token: 'refresh_tokens'
  has_many :refresh_tokens, dependent: :delete_all
  has_many :user_profiles
  has_many :profiles, through: :user_profiles, source: :profile
  has_one :current_user_profile, -> { where(current: true) }, class_name: 'UserProfile'
  has_one :current_profile, through: :current_user_profile, source: :profile

  def toggle_profile(profile)
    User.transaction do
      user_profiles.update_all(current: false)
      user_profiles.where(profile:).update!(current: true)
    end
  end
end
