require 'image_processing/mini_magick'

class ApplicationUploader < Shrine
  # define versions in each uploaders ot use defaults
  VERSIONS = {
    large: [300, 300],
    medium: [200, 200],
    small: [100, 100]
  }.freeze

  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)
    # rubocop:disable Style/HashTransformValues
    VERSIONS.each_with_object({}) do |(version, sizes), memo|
      memo[version] = magick.resize_to_limit!(*sizes)
    end
    # rubocop:enable Style/HashTransformValues
  end

  Attacher.promote_block do
    ImagePromoteJob.perform_later(self.class.name, record.class.name, record.id, name, file_data)
  end

  Attacher.destroy_block do
    ImageDestroyJob.perform_later(self.class.name, data)
  end
end
