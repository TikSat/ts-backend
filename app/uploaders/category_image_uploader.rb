require 'image_processing/mini_magick'

class CategoryImageUploader < Shrine
  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)

    {
      large: magick.resize_to_limit!(300, 300),
      medium: magick.resize_to_limit!(200, 200),
      small: magick.resize_to_limit!(100, 100)
    }
  end

  Attacher.promote_block do
    ImagePromoteJob.perform_async(self.class.name, record.class.name, record.id, name, file_data)
  end

  Attacher.destroy_block do
    ImageDestroyJob.perform_async(self.class.name, data)
  end
end
