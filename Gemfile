source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'api_guard'
gem 'bcrypt'
gem 'bootsnap', require: false
gem 'dotenv'
gem 'factory_bot' # move it to dev group after release
gem 'faker' # move it to dev group after release
gem 'fastimage'
gem 'foreman'
gem 'friendly_id'
gem 'image_processing', '~> 1.8'
gem 'jwt'
gem 'multi_json'
gem 'pagy'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.2', '>= 7.0.2.3'
gem 'redis', '~> 4.0'
gem 'roar'
gem 'rspec'
gem 'rswag'
gem 'sentry-rails'
gem 'sentry-ruby'
gem 'sentry-sidekiq'
gem 'shrine', github: 'shrinerb/shrine'
gem 'sidekiq'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'annotate'
  gem 'rubocop'
  gem 'rubocop-performance', require: false
  gem 'rubocop-rspec'
end

group :test do
  gem 'rspec-rails'
  gem 'rspec-sidekiq'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'test-prof'
  gem 'timecop'
end

group :production do
  gem 'newrelic_rpm'
end
