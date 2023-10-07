require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module StevenKlavins2023
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Include custom libs.
    config.autoload_paths << Rails.root.join('lib')

    # Compress HTML Responses
    config.middleware.use Rack::Deflater

    # Ensure assets enabled
    config.assets.enabled = true

    # Precompile everything needed
    config.assets.precompile += %w( *.js *.css *.jpg *jpeg *.png *.svg *ico *.ttf *.woff *.eot )

    # Use VIPs
    Rails.application.config.active_storage.variant_processor = :vips

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
