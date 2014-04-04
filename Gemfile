source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '4.0.2'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'pg'
gem 'devise'
gem 'warden'
gem 'cancan'
gem 'squeel'
gem 'friendly_id', '~> 5.0.0'
gem 'simple_form'
gem 'simplecov'
gem 'json'
gem 'less-rails'
gem 'sass-rails'
gem 'coffee-rails'
gem 'therubyracer', :platforms => :ruby
gem 'uglifier'
#gem 'jquery-ui-rails'
gem 'gon'
gem 'rabl'
gem 'smarter_csv'
gem 'omniauth-twitter'
gem 'omniauth-facebook', '1.4.0'
gem 'omniauth-google-oauth2'
gem 'grabzit'
gem 'select2-rails'
gem 'carrierwave'
gem "fog", "~> 1.3.1"
gem "best_in_place", github: 'bernat/best_in_place', branch: "rails-4"
gem 'rmagick', '2.13.2', require: false #=> requires `brew install imagemagick`
gem 'acts-as-taggable-on', '~> 3.0.2'




group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :production, :integration, :staging do
  gem 'thin'
  gem 'rails_12factor'
end


group :development, :test do
  gem 'rspec-rails'
  gem 'faker'
  gem 'factory_girl_rails'
end

group :development do
  gem 'annotate'
  gem 'meta_request', require: false # for RailsPanel https://github.com/dejan/rails_panel
  gem 'rack-mini-profiler'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'capybara'
  gem 'xpath'
  gem 'email_spec'
  gem 'launchy'
  gem 'database_cleaner', git: 'git://github.com/bmabey/database_cleaner.git'
  gem 'guard-rspec'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '2.5.0'
  gem 'capybara-webkit'
  gem 'spork-rails'
  gem 'guard-spork'
end
