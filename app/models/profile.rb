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
#  time_zone    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Profile < ApplicationRecord
  self.inheritance_column = 'profile_type'
  include ProfileAvatarUploader::Attachment(:avatar)
  include ProfileCoverUploader::Attachment(:cover)

  has_many :user_profiles
  has_many :users, through: :user_profiles
end
