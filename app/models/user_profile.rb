# == Schema Information
#
# Table name: user_profiles
#
#  id         :uuid             not null, primary key
#  current    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  profile_id :uuid
#  user_id    :uuid
#
# Indexes
#
#  index_user_profiles_on_profile_id              (profile_id)
#  index_user_profiles_on_user_id                 (user_id)
#  index_user_profiles_on_user_id_and_profile_id  (user_id,profile_id) UNIQUE
#
class UserProfile < ApplicationRecord
  belongs_to :user
  belongs_to :profile
end
