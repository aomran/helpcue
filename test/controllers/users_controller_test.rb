require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    sign_in users(:teacher1)
  end

  test "owner can remove students" do
    sign_out users(:teacher1)
    sign_in users(:teacher2) #owner
    assert_difference 'classrooms(:two).users.count', -1 do
      xhr :delete, :destroy, classroom_id: classrooms(:two), id: users(:student1).id
    end
  end

  test "admin can remove students" do
    assert_difference 'classrooms(:two).users.count', -1 do
      xhr :delete, :destroy, classroom_id: classrooms(:two), id: users(:student1).id
    end
  end

  test "admin can not remove owner" do
    assert_no_difference 'classrooms(:two).users.count' do
      xhr :delete, :destroy, classroom_id: classrooms(:two), id: users(:teacher2).id
    end
  end

  test "owner can promote users" do
    sign_out users(:teacher1)
    sign_in users(:teacher2) #owner

    xhr :patch, :update, classroom_id: classrooms(:two), id: users(:student2).id, promote: true

    assert classrooms(:two).teachers.include?(users(:student2))
  end

  test "owner can demote admin" do
    sign_out users(:teacher1)
    sign_in users(:teacher2) #owner

    xhr :patch, :update, classroom_id: classrooms(:two), id: users(:teacher1).id, promote: false

    assert classrooms(:two).students.include?(users(:teacher1))
  end
end
