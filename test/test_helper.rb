ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def json(body)
    JSON.parse(body, symbolize_names: true)
  end

  def setup
    Bullet.start_request if Bullet.enable?
  end

  def teardown
    Bullet.perform_out_of_channel_notifications if Bullet.enable? && Bullet.notification?
    Bullet.end_request if Bullet.enable?
    Timecop.return
  end
end

class ActionController::TestCase
  include Devise::TestHelpers
end