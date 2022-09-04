class CategoryImageUploader < ApplicationUploader
  def self.versions
    {
      lg: [300, 300],
      md: [200, 200],
      sm: [100, 100],
      xs: [60, 60]
    }
  end
end
