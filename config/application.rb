require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Nshvll
  class Application < Rails::Application
    # JavaScript files you want as :defaults (application.js is always included).
    config.action_view.javascript_expansions[:defaults] = %w(jquery-1.4.2.min jquery.easing.1.3 jquery.uniform.min)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    ActionMailer::Base.smtp_settings = {
      :port           => ENV['MAILGUN_SMTP_PORT'],
      :address        => ENV['MAILGUN_SMTP_SERVER'],
      :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
      :password       => ENV['MAILGUN_SMTP_PASSWORD'],
      :domain         => 'nshvll.heroku.com',
      :authentication => :plain,
    }
    ActionMailer::Base.delivery_method = :smtp
  end
end

ADMIN_EMAIL = 'traviskroberts@gmail.com'
