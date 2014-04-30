require 'test_helper'

class RequestsControllerTest < ActionController::TestCase
  def setup
    sign_in users(:student1)
    @params = {
      classroom_id: classrooms(:two),
      request: {
        question: 'I am a #question'
      }
    }
  end

  test "should get list of requests" do
    get :index, classroom_id: classrooms(:two).id

    assert assigns(:requests)
    assert :success
  end

  test "should get list of completed requests" do
    get :completed, classroom_id: classrooms(:two).id

    assert assigns(:requests)
    assert :success
  end

  test "should get requests containing query" do
    classrooms(:two).requests.create(question: 'question about jerky', owner_id: users(:student1).id)
    get :search, classroom_id: classrooms(:two).id, query: 'jerky'

    assert_equal 1, assigns(:requests).count
    assert :success
  end

  test "should create request with valid data" do
    assert_difference 'Request.count' do
      @params[:format] = :json
      xhr :post, :create, @params
    end

    assert_equal Request::STATUS_OPTIONS[0], Request.last.status
    assert_equal @params[:request][:question], Request.last.question
    assert_equal users(:student1).id, Request.last.owner_id
  end

  test "should update request question" do
    xhr :patch, :update, classroom_id: classrooms(:two), id: requests(:one).id , request: {question: 'new question'}

    assert_equal 'new question', requests(:one).reload.question
  end

  test "should toggle request status from waiting to being helped" do
    xhr :patch, :toggle_help, classroom_id: classrooms(:two), id: requests(:one).id

    assert_equal Request::STATUS_OPTIONS[1], requests(:one).reload.status
  end

  test "should toggle request status from being helped to waiting" do
    sign_out users(:student1)
    sign_in users(:student2)
    xhr :patch, :toggle_help, classroom_id: classrooms(:two), id: requests(:two).id

    assert_equal Request::STATUS_OPTIONS[0], requests(:two).reload.status
  end

  test "should remove request when it's done" do
    xhr :patch, :remove, classroom_id: classrooms(:two), id: requests(:one).id

    assert_equal Request::STATUS_OPTIONS[2], requests(:one).reload.status
  end

  test "should delete request" do
    sign_out users(:student1)
    sign_in users(:student2)
    assert_difference 'classrooms(:two).requests.count', -1 do
      xhr :delete, :destroy, classroom_id: classrooms(:two), id: requests(:two).id
    end
  end

  test "teacher should be able to delete request" do
    sign_out users(:student1)
    sign_in users(:teacher1)
    assert_difference 'classrooms(:two).requests.count', -1 do
      xhr :delete, :destroy, classroom_id: classrooms(:two), id: requests(:two).id
    end
  end

  test "should add additional student to request" do
    sign_out users(:student1)
    sign_in users(:student2)
    assert_difference 'requests(:one).users.count' do
      xhr :patch, :me_too, classroom_id: classrooms(:two), id: requests(:one).id
    end
  end

  test "should add additional student to request only once, instead removing them" do
    sign_out users(:student1)
    sign_in users(:student2)
    xhr :patch, :me_too, classroom_id: classrooms(:two), id: requests(:one).id

    assert_difference 'requests(:one).users.count', -1 do
      xhr :patch, :me_too, classroom_id: classrooms(:two), id: requests(:one).id
    end
  end

  test "should not allow teacher to me-too a request" do
    sign_out users(:student1)
    sign_in users(:teacher1)

    assert_no_difference 'requests(:one).users.count' do
      xhr :patch, :me_too, classroom_id: classrooms(:two), id: requests(:one).id
    end

    assert "You are not authorized to perform this action.", flash[:error]
  end
end
