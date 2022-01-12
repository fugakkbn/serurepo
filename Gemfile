# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

gem 'active_flag'
gem 'aws-sdk-rails'
gem 'aws-ses'
gem 'bulma-rails', '~> 0.9.1'
gem 'capybara', '>= 3.26'
gem 'devise'
gem 'devise-i18n'
gem 'httpclient'
gem 'meta-tags'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'premailer-rails'
gem 'selenium-webdriver'
gem 'slim-rails'
gem 'whenever', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capistrano', '~> 3.16', require: false
  gem 'capistrano3-puma'
  gem 'capistrano-bundler'
  gem 'capistrano-rails', '~> 1.3', require: false
  gem 'capistrano-rbenv'
  gem 'capistrano-rbenv-vars'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'rubocop-fjord', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'bcrypt_pbkdf'
  gem 'ed25519'
  gem 'html2slim'
  gem 'letter_opener_web', '~> 1.0'
  gem 'slim_lint'
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'codecov', require: false
  gem 'database_rewinder'
  gem 'simplecov', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
