require 'test_helper'

class ClassroomPolicyTest < ActiveSupport::TestCase
  def setup
    @classroom = classrooms(:two)
    @teacher = users(:teacher1)
    @student = users(:student1)
    @mentor  = users(:mentor1)
  end

  test "admin and mentors should be able to update a classroom" do
    policy = ClassroomPolicy.new(@teacher, @classroom)
    assert policy.update?
  end

  test "student should not be able to update a classroom" do
    policy = ClassroomPolicy.new(@student, @classroom)
    refute policy.update?
  end

  test "mentors should not be able to do admin tasks" do
    policy = ClassroomPolicy.new(@mentor, @classroom)
    refute policy.admin?
  end

  test "Admin that are not owners should not be able to do owner tasks" do
    policy = ClassroomPolicy.new(@teacher, @classroom)
    refute policy.owner?
  end
end
