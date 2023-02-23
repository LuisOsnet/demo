# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = Figaro.env.sentry_dns

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |_context|
    true
  end
end
