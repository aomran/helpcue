require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    sign_in users(:teacher1)
  end

  test "should get list of teachers and students in the classroom" do
    get :index, classroom_id: classrooms(:one)

    assert assigns(:admins)
    assert :success
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

  test "owner can change user role to admin" do
    sign_out users(:teacher1)
    sign_in users(:teacher2) #owner

    xhr :patch, :update, classroom_id: classrooms(:two), id: users(:student2).id, role: Enrollment::ROLES[0]

    assert classrooms(:two).admins.include?(users(:student2))

    response = JSON.parse(@response.body)
    assert_equal Enrollment::ROLES[0], response['role']
  end

  test "owner can change user role to mentor" do
    sign_out users(:teacher1)
    sign_in users(:teacher2) #owner

    xhr :patch, :update, classroom_id: classrooms(:two), id: users(:student2).id, role: Enrollment::ROLES[1]

    assert classrooms(:two).mentors.include?(users(:student2))
  end

  test "owner can change admin role to member" do
    sign_out users(:teacher1)
    sign_in users(:teacher2) #owner

    xhr :patch, :update, classroom_id: classrooms(:two), id: users(:teacher1).id, role: Enrollment::ROLES[2]

    assert classrooms(:two).members.include?(users(:teacher1))
  end

  test "owner can pass ownership to another user" do
    sign_out users(:teacher1)
    sign_in users(:teacher2) #owner

    xhr :patch, :update, classroom_id: classrooms(:two), id: users(:teacher1).id, role: 'Owner'

    assert_equal users(:teacher1), classrooms(:two).reload.owner
  end
end
