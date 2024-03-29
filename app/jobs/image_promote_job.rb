class ImagePromoteJob < ApplicationJob
  def perform(attacher_class, record_class, record_id, name, file_data)
    attacher_class = Object.const_get(attacher_class)
    record         = Object.const_get(record_class).find(record_id) # if using Active Record

    attacher = attacher_class.retrieve(model: record, name:, file: file_data)
    attacher.create_derivatives # calls derivatives processor
    attacher.atomic_promote
  rescue Shrine::AttachmentChanged, ActiveRecord::RecordNotFound => e
    Sentry.capture_exception(e)
    # attachment has changed or the record has been deleted, nothing to do
  rescue StandardError => e
    Sentry.capture_exception(e)
    raise e
  end
end
