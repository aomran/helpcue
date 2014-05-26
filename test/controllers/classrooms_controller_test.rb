require 'test_helper'

class ClassroomsControllerTest < ActionController::TestCase

  def setup
    sign_in users(:teacher1)
  end

  test "get list of classrooms" do
    get :index
    assert assigns(:classrooms)
    assert :success
  end

  test "should create classroom with valid data" do
    assert_difference 'users(:teacher1).classrooms.count' do
      xhr :post, :create, format: :json, classroom: {name: "Test classroom"}
    end

    response = JSON.parse(@response.body)
    assert response["partial"]
  end

  test "should not create classroom with invalid data" do
    xhr :post, :create, format: :json, classroom: { name: nil }

    response = JSON.parse(@response.body)
    assert response["name"]
  end


  test "should update classroom with valid data" do
    xhr :patch, :update, id: classrooms(:one), classroom: {name: "Changed name" }

    classroom = Classroom.find(classrooms(:one).id)
    assert_equal "Changed name", classroom.name, 'Name did not change'

    response = JSON.parse(@response.body)
    assert response["partial"], 'Partial was not sent in response body'
  end

  test "should not update classroom with invalid data" do
    xhr :patch, :update, id: classrooms(:one), classroom: {name: nil }

    response = JSON.parse(@response.body)
    assert response["name"]
  end

  test "should remove user from classroom without deleting classroom" do
    assert_difference 'users(:teacher1).classrooms.count', -1 do
      xhr :delete, :destroy, id: classrooms(:one)
    end

    assert classrooms(:one).reload
    response = JSON.parse(@response.body)
    assert response["id"]
  end

  test "should remove classroom with no users" do
    xhr :delete, :destroy, id: classrooms(:one)

    sign_out users(:teacher1)
    sign_in users(:teacher2)

    assert_difference 'Classroom.count', -1 do
      xhr :delete, :destroy, id: classrooms(:one)
    end
  end

  test "should give error with wrong token" do
    xhr :post, :join, format: :json, join_token: 'bad-token'

    assert_equal 'Invalid Token', @response.body
  end

  test "should add user with user role to classroom with user-token" do
    assert_equal 1, users(:student1).classrooms.size

    sign_out users(:teacher1)
    sign_in users(:student1)

    xhr :post, :join, format: :json, join_token: classrooms(:one).user_token

    assert_equal 2, users(:student1).classrooms.size
    assert_equal 'User', users(:student1).classroom_users.last.role
  end

  test "should not add user to a classroom they are already in" do

    assert_no_difference 'users(:teacher1).classrooms.count' do
      xhr :post, :join, format: :json, join_token: classrooms(:one).user_token
    end

    assert_equal 'You are already in this classroom', @response.body
  end

  test "should get list of teachers and students in the classroom" do
    get :people, id: classrooms(:one)

    assert assigns(:teachers)
    assert assigns(:students)
    assert :success
  end

  test "change sort of queue to by-popularity" do
    xhr :patch, :set_sort, id: classrooms(:one), sort_type: 'popularity'

    assert_equal true, classrooms(:one).reload.sort_by_popularity?
  end

  test "change sort of queue back to by-time" do
    xhr :patch, :set_sort, id: classrooms(:one), sort_type: 'popularity'
    xhr :patch, :set_sort, id: classrooms(:one), sort_type: 'time'

    assert_equal true, classrooms(:one).reload.sort_by_time?
  end

  test "non-admin can't change sort type" do
    sign_out users(:teacher1)
    sign_in users(:student1)

    xhr :patch, :set_sort, id: classrooms(:two), sort_type: 'popularity'

    assert "You are not authorized to perform this action.", flash[:error]
  end

end