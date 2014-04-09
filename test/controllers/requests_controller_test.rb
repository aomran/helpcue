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

  test "should create request with valid data" do
    assert_difference 'Request.count' do
      @params[:format] = :json
      xhr :post, :create, @params
    end

    assert_equal Request::STATUS_OPTIONS[0], Request.last.status
    assert_equal @params[:request][:question], Request.last.question
    assert_equal users(:student1).id, Request.last.owner_id
  end

  test "should update request status" do
    xhr :patch, :update, classroom_id: classrooms(:two), id: requests(:one).id , request: {status: Request::STATUS_OPTIONS[1]}

    assert_equal Request::STATUS_OPTIONS[1], requests(:one).reload.status
  end

  test "should update request question" do
    xhr :patch, :update, classroom_id: classrooms(:two), id: requests(:one).id , request: {question: 'new question'}

    assert_equal 'new question', requests(:one).reload.question
  end
end
