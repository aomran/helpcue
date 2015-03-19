require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  setup do
    @current_time = Time.zone.now
  end

  test "toggle status from waiting to being-helped" do
    requests(:one).toggle_status.save

    assert_equal Request::STATUS_OPTIONS[1], requests(:one).reload.status
  end

  test "toggle status from being-helped to waiting" do
    requests(:two).toggle_status.save

    assert_equal Request::STATUS_OPTIONS[0], requests(:two).reload.status
  end

  test "adds current time when changing status to being-helped" do
    travel_to @current_time
    requests(:one).toggle_status.save

    assert_equal @current_time.to_s, requests(:one).reload.helped_at.to_s
  end

  test "adds current time when changing status to done" do
    travel_to @current_time
    requests(:one).remove_from_queue.save

    assert_equal @current_time.to_s, requests(:one).reload.done_at.to_s
  end

  test "time waiting" do
    request = Request.create
    travel(30.minutes) do
      request.toggle_status.save
      assert_equal 30.minutes, request.time_waiting
    end
  end

  test "help duration" do
    request = Request.create
    request.toggle_status.save

    travel(40.minutes) do
      request.remove_from_queue.save
      assert_equal 40.minutes, request.help_duration
    end
  end
end
