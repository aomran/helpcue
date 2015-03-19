ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def login_as(user)
    visit new_user_session_path
    fill_in :user_email, with: user.email
    fill_in :user_password, with: 'password123'
    click_button 'Login'
  end

  def log_out
    click_link 'Account'
    click_link 'Log Out'
  end

  def teardown
    travel_back
  end
end

class ActionController::TestCase
  include Devise::TestHelpers
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  Capybara.current_driver = Capybara.javascript_driver
  Capybara.default_wait_time = 5
end
