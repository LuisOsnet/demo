# frozen_string_literal: true

# Handle error messages
module SentryNotify
  extend ActiveSupport::Concern

  def notify(exception)
    Sentry.capture_exception(exception)
    Sentry.capture_message(exception.message)
  end
end
