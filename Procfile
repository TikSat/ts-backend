web: bundle exec puma -e production
worker: bundle exec sidekiq -C config/sidekiq.yml
release: bundle exec rails db:migrate
