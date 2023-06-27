require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)
Dotenv::Railtie.load if %w[development test].include? ENV["RAILS_ENV"]

module Scissors
  class Application < Rails::Application
    config.load_defaults 7.0
    config.eager_load_paths << Rails.root.join("lib")

    config.api_only = true
  end
end
