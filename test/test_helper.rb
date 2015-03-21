ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/poltergeist'
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
    click_link 'Account'
    click_link 'Log Out'
  end

  def setup
    Pusher.stubs(:trigger)
  end

  def teardown
    travel_back
  end
end

class ActionController::TestCase
  include Devise::TestHelpers
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, {js_errors: false})
  end
  Capybara.javascript_driver = :poltergeist
  Capybara.current_driver = Capybara.javascript_driver
  Capybara.default_wait_time = 10
end
