require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Demo
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.i18n.fallbacks = true
    config.i18n.available_locales = %w[es]
    config.i18n.default_locale = :es
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.api_only = true
    config.session_store :cookie_store, key: '_interslice_session'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Flash
    config.middleware.use config.session_store, config.session_options

    # Access-Control-Allow-Origin
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'localhost:3000', /https*:\/\/.*?herokuapp\.com/
        resource '*', :headers => :any, :methods => :any
      end
    end
  end
end
