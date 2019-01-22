# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SoireeGageure2017
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults Rails::VERSION::STRING.to_f

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths << Rails.root.join('components', 'registration_process', 'app', 'models')
    config.autoload_paths << Rails.root.join('components', 'registration_process', 'app', 'controllers')
    config.autoload_paths << Rails.root.join('components', 'draw_bookkeeping', 'app', 'controllers')
    config.autoload_paths << Rails.root.join('components', 'draw_bookkeeping', 'app', 'models')

    # Custom paths, eager loaded in production
    config.eager_load_paths << Rails.root.join('components', 'registration_process', 'app', 'models')
    config.eager_load_paths << Rails.root.join('components', 'registration_process', 'app', 'controllers')
    config.eager_load_paths << Rails.root.join('components', 'draw_bookkeeping', 'app', 'controllers')
    config.eager_load_paths << Rails.root.join('components', 'draw_bookkeeping', 'app', 'models')

    config.i18n.default_locale = :fr
  end
end
