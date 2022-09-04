class ListingImageUploader < ApplicationUploader
  def self.versions
    {
      lg: [640, 480],
      md: [320, 240],
      sm: [200, 150],
      xs: [100, 75]
    }
  end
end
