#!/usr/bin/env ruby
# frozen_string_literal: true

require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app,
                                 browser: :chrome,
                                 desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
                                   chrome_options: {
                                     args: %w[headless disable-gpu window-size=1280,800],
                                     w3c: false
                                   }
                                 ))
end
Capybara.javascript_driver = :selenium
Capybara.default_driver = :selenium

class Crawler
  def start_scraping(url, &block)
    Capybara::Session.new(:selenium).tap do |session|
      session.visit url
      session.instance_eval(&block)
    end
  end
end
