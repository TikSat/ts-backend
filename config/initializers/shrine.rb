require 'shrine'
require 'shrine/storage/s3'
if Rails.env.test?
  Shrine.storages = {
    cache: Shrine::Storage::Memory.new(prefix: 'cache'), # temporary
    store: Shrine::Storage::Memory.new(prefix: 'store') # permanent
  }
else
  bucket = Rails.env.production? ? 'tiksat-prod' : 'tiksat-dev'
  s3_options = {
    bucket:, # required
    region: 'us-east-1', # required
    access_key_id: ENV.fetch('S3_ACCESS_KEY'),
    secret_access_key: ENV.fetch('S3_SECRET_KEY'),
    endpoint: 'https://fra1.digitaloceanspaces.com',
    public: true
  }

  Shrine.storages = {
    cache: Shrine::Storage::S3.new(prefix: 'cache', **s3_options), # temporary
    store: Shrine::Storage::S3.new(prefix: 'store', **s3_options) # permanent
  }
end

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for retaining the cached file across form redisplays
Shrine.plugin :restore_cached_data # re-extract metadata when attaching a cached file
# Shrine.plugin :rack_file # for non-Rails apps
Shrine.plugin :backgrounding
Shrine.plugin :store_dimensions
Shrine.plugin :validation_helpers
Shrine.plugin :derivatives
Shrine.plugin :remote_url, max_size: 20 * 1024 * 1024
Shrine.plugin :determine_mime_type
