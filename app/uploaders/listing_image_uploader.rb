class ListingImageUploader < ApplicationUploader
  VERSIONS = {
    large: [200, 300],
    medium: [100, 200],
    small: [50, 150]
  }.freeze
end
