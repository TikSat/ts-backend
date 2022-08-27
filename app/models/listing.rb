# == Schema Information
#
# Table name: listings
#
#  id           :uuid             not null, primary key
#  active       :boolean          default(TRUE), not null
#  desc         :text
#  expires_at   :datetime
#  field_values :jsonb
#  slug         :string
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  category_id  :uuid
#  profile_id   :uuid
#
# Indexes
#
#  idx_field_values               ((((field_values ->> 'field_id'::text))::uuid))
#  index_listings_on_category_id  (category_id)
#  index_listings_on_profile_id   (profile_id)
#  index_listings_on_slug         (slug) UNIQUE
#  index_listings_on_title        (title)
#
class Listing < ApplicationRecord
  include PgSearch::Model
  belongs_to :category
  belongs_to :author, class_name: 'Profile', foreign_key: :profile_id
  has_many :custom_fields, through: :category

  extend FriendlyId
  friendly_id :title, use: :slugged

  before_create :set_expires_at

  pg_search_scope :search_by_title,
                  against: :title,
                  using: {
                    tsearch: { prefix: true }
                  }

  pg_search_scope :search_by_desc,
                  against: :desc

  private

  def set_expires_at
    self.expires_at = 1.week.from_now
  end
end
