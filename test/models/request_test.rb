require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  test "toggle status from waiting to being-helped" do
    requests(:one).toggle_status.save

    assert_equal Request::STATUS_OPTIONS[1], requests(:one).reload.status
  end

  test "toggle status from being-helped to waiting" do
    requests(:two).toggle_status.save

    assert_equal Request::STATUS_OPTIONS[0], requests(:two).reload.status
  end
end
