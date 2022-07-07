source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'bootsnap', require: false
gem 'image_processing', '~> 1.8'
gem 'jsonapi-serializer'
gem 'jwt'
gem 'pagy'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.2', '>= 7.0.2.3'
gem 'redis', '~> 4.0'
gem 'rswag'
gem 'sentry-rails'
gem 'sentry-ruby'
gem 'sentry-sidekiq'
gem 'shrine', github: 'shrinerb/shrine'
gem 'sidekiq'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'factory_bot'
  gem 'faker'
  gem 'multi_json'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rspec-sidekiq'
  gem 'rubocop-rspec'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'test-prof'
  gem 'timecop'
end

group :development do
  gem 'annotate'
  gem 'rubocop'
  gem 'rubocop-performance', require: false
end

group :production do
  gem 'newrelic_rpm'
end
