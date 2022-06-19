#!/usr/bin/env ruby
# frozen_string_literal: true

require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

Capybara.register_driver :selenium do |app|
  caps = Selenium::WebDriver::Remote::Capabilities.chrome(
    'goog:chromeOptions' => { args: %w[headless disable-gpu no-sandbox disable-dev-shm-usage remote-debugging-port=9222 window-size=1280,800] }
  )
  Capybara::Selenium::Driver.new(app,
                                 browser: :chrome,
                                 capabilities: caps,
                                 timeout: 600)
end
Capybara.javascript_driver = :selenium
Capybara.default_driver = :selenium

class Crawler
  def start_scraping(url, &block)
    Capybara::Session.new(:selenium).tap do |session|
      session.visit url
      session.instance_eval(&block)
    rescue StandardError => e
      logger = Logger.new('log/crawler.log')
      logger << "scraping_error: #{session.inspect} #{e.message}\n"
    ensure
      session.quit
    end
  end
end
