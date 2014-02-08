source 'https://rubygems.org'

gem 'rails', '4.0.1'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'pg'
gem 'devise'
gem 'warden'
gem 'cancan'
gem 'squeel'
gem 'friendly_id'
gem 'simple_form'
gem 'simplecov'
gem 'json'
gem 'less-rails'
gem 'coffee-rails'
gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', :platforms => :ruby
gem 'uglifier'
gem 'chosen-rails'
gem 'jquery-ui-rails'
gem 'gon'
gem 'rails_12factor', group: :production


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :production, :integration do
  gem 'thin'
end



gem 'rspec-rails', group: [:test, :development]

group :test do
  gem 'cucumber-rails', require: false
  gem 'capybara'
  gem 'xpath'
  gem 'email_spec'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'guard-rspec'
  gem 'factory_girl_rails'
  gem 'selenium-webdriver'
end