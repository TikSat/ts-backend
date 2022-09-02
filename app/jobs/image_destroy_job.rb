class ImageDestroyJob < ApplicationJob
  def perform(attacher_class, data)
    attacher_class = Object.const_get(attacher_class)

    attacher = attacher_class.from_data(data)
    attacher.destroy
  rescue StandardError => e
    Sentry.capture_exception(e)
    # attachment has changed or the record has been deleted, nothing to do
  end
end
