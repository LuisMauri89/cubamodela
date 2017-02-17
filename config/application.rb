require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cubamodela
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.i18n.default_locale = :es
    config.i18n.available_locales = [:en, :es]

    config.time_zone = "Eastern Time (US & Canada)"

    # config.exceptions_app = ->(env) { ExceptionsController.action(:show).call(env) }

    config.secret_key_base = 'bff083a75590c82f5a2944dde448aa6df73a3220b8c71ec9c5520759d2eb0e8ccc9b6252b0652314d43013a7b40e9ddf8dba94deb0c8f61b9ed9eb058b908df0'
  end
end
