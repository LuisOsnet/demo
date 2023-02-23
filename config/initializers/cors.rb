# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:3001', %r{https*://.*?herokuapp\.com(/.*)?$}, %r{https*://.*?ngrok\.io(/.*)?$}
    resource '*', headers: :any, methods: %i[get post put delete destroy options], expose: ['Authorization']
  end
end
