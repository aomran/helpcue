require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    sign_in users(:teacher1)
  end

  test "owner can remove students" do
    sign_out users(:teacher1)
    sign_in users(:teacher2)
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
end
