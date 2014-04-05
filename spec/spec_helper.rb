# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'

require 'simplecov'
SimpleCov.start


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # treat symbols as metadata keys with a value of `true`
  config.treat_symbols_as_metadata_keys_with_true_values = true

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.include Devise::TestHelpers, :type => :controller

  # Database cleaner
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
  config.include WaitForAjax, type: :feature

##omniauth test support
  OmniAuth.config.test_mode = true

## facebook
  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      {provider: "facebook",
       uid:      "1234",
       extra: {raw_info:    {name:  "John Doe",
                             email: "johndoe@email.com"}
       }
      })


##twitter
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
      {
          provider: 'twitter',
          uid:      '123545',
          info:     {nickname: 'twitter_nickname' }
      })

#linked in
  OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new(
    {
      provider: "linkedin",
      uid:      "12345",
      extra: {raw_info:    {name:  "John Doelinked",
                            email: "johndoelinked@email.com"}
              }
    }
  )


#fakesocialmedia
  OmniAuth.config.mock_auth[:fakesocialmedia] = OmniAuth::AuthHash.new(
    {
      provider: "fake",
      uid:      "000000",
      extra: {raw_info:    {name:  "Fake Media",
                           email: "johndoefake@email.com"}
     }
    }
  )
end
