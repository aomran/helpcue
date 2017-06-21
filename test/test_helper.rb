require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/mini_test'

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
    Capybara.reset_sessions!
  end

  def json
    JSON.parse(@response.body)
  end

end

class ActionController::TestCase
  include Devise::Test::ControllerHelpers
end
