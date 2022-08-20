Sentry.init do |config|
  config.dsn = 'https://8c01243c992740e4924b6822aa4177a1@o1367671.ingest.sentry.io/6668610'
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 0.1
  # or
  config.traces_sampler = lambda do |_context|
    true
  end
end
