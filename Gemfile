# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "bootsnap", require: false
gem "pg"
gem "rails", "~> 6.1.0"
gem "sassc-rails"
# Use Puma as the app server
gem "puma", "~> 6.1"
# Use SCSS for stylesheets
# gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.11"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
#
gem "activeadmin"
gem "responders"

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  # gem "capybara", ">= 2.15"
  gem "factory_bot_rails"
  gem "rspec-rails"
  # gem "selenium-webdriver"
end

group :development do
  gem "listen"

  gem "rubocop-govuk"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-rspec"

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen"

  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  # gem "web-console", ">= 3.3.0"
end

group :test do
  gem "database_cleaner"
  gem "rails-controller-testing"
  gem "rspec_junit_formatter"
  gem "shoulda-matchers"
  gem "simplecov"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
