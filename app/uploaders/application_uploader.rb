require 'image_processing/vips'

class ApplicationUploader < Shrine
  Attacher.derivatives do |original|
    vips = ImageProcessing::Vips.source(original)
    # rubocop:disable Style/HashTransformValues
    shrine_class.versions.each_with_object({}) do |(version, sizes), memo|
      memo[version] = vips.resize_to_fit!(*sizes)
    end
    # rubocop:enable Style/HashTransformValues
  end

  def self.versions
    raise 'Define versions in uploader!'
  end

  Attacher.promote_block do
    ImagePromoteJob.perform_later(self.class.name, record.class.name, record.id, name, file_data)
  end

  Attacher.destroy_block do
    ImageDestroyJob.perform_later(self.class.name, data)
  end
end
