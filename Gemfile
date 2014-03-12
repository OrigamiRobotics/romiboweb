source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.2'
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
gem 'sass-rails'
gem 'coffee-rails'
#gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', :platforms => :ruby
gem 'uglifier'
gem 'chosen-rails'
#gem 'jquery-ui-rails'
gem 'gon'
gem 'rails_12factor', group: :production
gem 'rabl'
gem 'rack-mini-profiler'
gem 'smarter_csv'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :production, :integration do
  gem 'thin'
end



gem 'rspec-rails', group: [:test, :development]

group :development do
  gem 'annotate'
  gem 'meta_request', require: false # for RailsPanel https://github.com/dejan/rails_panel
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'capybara'
  gem 'xpath'
  gem 'email_spec'
  gem 'launchy'
  gem 'database_cleaner', git: 'git://github.com/bmabey/database_cleaner.git'
  gem 'guard-rspec'
  gem 'factory_girl_rails'
  gem 'selenium-webdriver'
  gem 'faker'
  gem 'shoulda-matchers'
  gem 'capybara-webkit'
end