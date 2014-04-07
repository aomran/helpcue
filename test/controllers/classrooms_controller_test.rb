require 'test_helper'

class ClassroomsControllerTest < ActionController::TestCase

  before do
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

  test "get edit classroom form" do
    get :edit, id: classrooms(:one)
    assert_equal classrooms(:one), assigns(:classroom)
    assert :success
  end

  test "should update classroom with valid data" do
    patch :update, id: classrooms(:one), classroom: {name: "Changed name" }

    classroom = Classroom.find(classrooms(:one).id)
    assert_equal "Changed name", classroom.name
    assert_redirected_to classroom_tracks_path(assigns(:classroom))
  end

  test "should not update classroom with invalid data" do
    patch :update, id: classrooms(:one), classroom: {name: nil }

    assert_template :edit
  end

  test "should remove teacher from classroom without deleting classroom" do
    assert_difference 'users(:teacher1).classrooms.count', -1 do
      delete :destroy, id: classrooms(:one)
    end

    assert classrooms(:one).reload
    assert_redirected_to classrooms_path
  end

  test "should remove student from classroom without deleting classroom" do
    cookies[:auth_token] = users(:student1).auth_token

    assert_difference 'users(:student1).classrooms.count', -1 do
      delete :destroy, id: classrooms(:one)
    end

    assert classrooms(:one).reload
    assert_redirected_to classrooms_path
  end

  test "should remove classroom with no teachers or students" do
    cookies[:auth_token] = users(:teacher2).auth_token
    assert_difference 'Classroom.count', -1 do
      delete :destroy, id: classrooms(:three)
    end
  end

  test "should add teacher to classroom" do
    assert_equal 1, users(:teacher1).classrooms.size
    xhr :post, :join, format: :json, teacher_token: classrooms(:three).teacher_token

    assert_equal 2, users(:teacher1).classrooms.size
  end

  test "should give error with wrong token" do
    xhr :post, :join, format: :json, teacher_token: 'bad-token'

    assert_equal 'Invalid Token', @response.body
  end

  test "should not add student to classroom using token" do
    assert_equal 1, users(:student1).classrooms.size

    cookies[:auth_token] = users(:student1).auth_token
    xhr :post, :join, format: :json, teacher_token: classrooms(:three).teacher_token

    assert_equal 1, users(:student1).classrooms.size
    assert 'Only a teacher can do that.', flash[:alert]
  end

  test "should not add teacher to a classroom they are already in" do

    assert_no_difference 'users(:teacher1).classrooms.count' do
      xhr :post, :join, format: :json, teacher_token: classrooms(:one).teacher_token
    end

    assert_equal 'You are already in this classroom', @response.body
  end

end