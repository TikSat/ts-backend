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
#  author_id    :uuid
#  category_id  :uuid
#
# Indexes
#
#  index_listings_on_author_id    (author_id)
#  index_listings_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => user_profiles.id)
#
FactoryBot.define do
  factory :listing do
    association :profile
    association :category
  end
end
