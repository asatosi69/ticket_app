require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TicketApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    
  
   config.i18n.default_locale = :ja

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    
    config.troupe_name = '三角'.freeze
    config.performance_name = 'おにぎり'.freeze
    config.performance_url = 'www.onigiri.com'.freeze
    config.performance_notice = '『お客様へのお願い』<br>・劇場の開場時間は公演開演時間の30分前となります。<br/><br/>'
    config.troupe_url = 'www.sankaku.com'.freeze

    config.default_payment_method_name = '当日精算'
  end
end
