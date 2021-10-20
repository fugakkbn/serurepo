# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Serurepo
  class Application < Rails::Application
    config.load_defaults 6.1
    config.i18n.default_locale = :ja

    config.generators do |g|
      g.test_framework :rspec,
                       view_specs: false,
                       helper_specs: false,
                       controller_specs: false,
                       routing_specs: false
      g.template_engine = :slim
      g.stylesheet_engine :sass
      g.javascripts false
      g.helper false
      g.assets false
    end

    config.generators.after_generate do |files|
      system('bundle exec rubocop --auto-correct-all ' + files.join(' '), exception: true)
    end

    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
  end
end
