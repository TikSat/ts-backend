# == Schema Information
#
# Table name: listing_images
#
#  id         :uuid             not null, primary key
#  image_data :jsonb
#  listing_id :uuid
#
# Indexes
#
#  index_listing_images_on_listing_id  (listing_id)
#
# Foreign Keys
#
#  fk_rails_...  (listing_id => listings.id)
#
class Listing::Image < ApplicationRecord
  include ListingImageUploader::Attachment.new(:image)
  belongs_to :listing
end
