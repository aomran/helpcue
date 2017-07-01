require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  setup do
    @current_time = Time.zone.now
  end

  test "toggle state from waiting to being-helped" do
    requests(:one).toggle_state.save

    assert_equal 'being_helped', requests(:one).reload.state
  end

  test "toggle state from being-helped to waiting" do
    requests(:two).toggle_state.save

    assert_equal 'waiting', requests(:two).reload.state
  end

  test "adds current time when changing state to being-helped" do
    travel_to @current_time
    requests(:one).toggle_state.save

    assert_equal @current_time.to_s, requests(:one).reload.helped_at.to_s
  end

  test "adds current time when changing state to done" do
    travel_to @current_time
    requests(:one).remove_from_queue.save

    assert_equal @current_time.to_s, requests(:one).reload.done_at.to_s
  end

  test "time waiting" do
    request = requests(:one)
    request.update_attribute(:created_at, @current_time)
    travel(30.minutes) do
      request.toggle_state.save
      assert_equal 30.minutes, request.time_waiting
    end
  end

  test "help duration" do
    request = requests(:one)
    request.toggle_state.save

    travel(40.minutes) do
      request.remove_from_queue.save
      assert_equal 40.minutes, request.help_duration
    end
  end

  def teardown
    travel_back
  end
end
