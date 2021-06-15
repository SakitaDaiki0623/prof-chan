# config/initializers/sentry.rb
Sentry.init do |config|
  config.dsn = 'https://a50238bb57f840e2a4683cd6867c7740:3a79472eeb8647e09890e54d930d1c23@o849648.ingest.sentry.io/5816581'
  config.breadcrumbs_logger = [:active_support_logger]

  # To activate performance monitoring, set one of these options.
  # We recommend adjusting the value in production:
  config.traces_sample_rate = 0.5
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end