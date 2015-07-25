require 'test_helper'

class ClassroomRoleTest < ActiveSupport::TestCase
  test "sort classroom users by role" do
    classroom = classrooms(:two)
    teacher = users(:teacher1)
    mentor = users(:mentor1)
    student = users(:student1)
    users = ClassroomRole.new(classroom, teacher).sorted_users

    assert users.index(teacher) < users.index(mentor)
    assert users.index(mentor) < users.index(student)
  end
end
