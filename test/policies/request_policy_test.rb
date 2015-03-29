require 'test_helper'

class RequestPolicyTest < ActiveSupport::TestCase
  def setup
    @teacher = users(:teacher1)
    @student1 = users(:student1)
    @student2 = users(:student2)
    @mentor  = users(:mentor1)
  end

  test "owner of request should be able to update the request" do
    policy = RequestPolicy.new(@student1, requests(:one))
    assert policy.update?
  end

  test "admin should be able to update the request" do
    policy = RequestPolicy.new(@teacher, requests(:one))
    assert policy.update?
  end

  test "Other students should not be able to update the request" do
    policy = RequestPolicy.new(@student2, requests(:one))
    refute policy.update?
  end

  test "admin should be able to toggle the request status from waiting to being-helped" do
    policy = RequestPolicy.new(@teacher, requests(:one))
    assert policy.toggle_help?
  end

  test "admin should be able to advance being-helped request to done" do
    policy = RequestPolicy.new(@teacher, requests(:two))
    assert policy.remove?
  end

  test "should not be able to advance waiting request to done" do
    policy = RequestPolicy.new(@teacher, requests(:one))
    refute policy.remove?
  end

  test "should be able to destroy request that is waiting" do
    policy = RequestPolicy.new(@teacher, requests(:one))
    assert policy.destroy?
  end

  test "should not be able to destroy request that is being-helped" do
    policy = RequestPolicy.new(@teacher, requests(:two))
    refute policy.destroy?
  end

  test "owner and admin of request should not be able to me-too it" do
    policy = RequestPolicy.new(@student1, requests(:one))
    refute policy.me_too?

    policy = RequestPolicy.new(@teacher, requests(:one))
    refute policy.me_too?
  end

  test "Other students should be able to me-too a request" do
    policy = RequestPolicy.new(@student2, requests(:one))
    assert policy.me_too?
  end

end
