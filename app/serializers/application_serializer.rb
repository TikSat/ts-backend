class ApplicationSerializer
  include ::JSONAPI::Serializer
  cache_options store: Rails.cache,
                namespace: self.class.name.underscore.to_s,
                expires_in: 1.hour

  def resource
    @resource
  end
end
