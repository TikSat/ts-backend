# == Schema Information
#
# Table name: listings
#
#  id           :uuid             not null, primary key
#  active       :boolean          default(TRUE), not null
#  expires_at   :datetime
#  field_values :jsonb
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  category_id  :uuid
#  profiles_id  :uuid
#
# Indexes
#
#  index_listings_on_category_id  (category_id)
#  index_listings_on_profiles_id  (profiles_id)
#
class Listing < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'UserProfile', foreign_key: :profiles_id
end
