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

  test "should get list of requests in JSON" do
    xhr :get, :index, format: :json, classroom_id: classrooms(:two).id

    response_body = JSON.parse(@response.body)

    assert_equal classrooms(:two).requests.need_help.count, response_body.length
  end

  test "should get list of completed requests" do
    get :completed, classroom_id: classrooms(:two).id

    assert assigns(:requests)
    assert :success
  end

  test "user export csv" do
    get :completed, classroom_id: classrooms(:two).id, format: :csv
    csv_array = CSV.parse @response.body

    assert_equal ["user", "question", "answer", "created_at"], csv_array[0]
    assert :success
  end

  test "admin export csv" do
    sign_out users(:student1)
    sign_in users(:teacher1)

    get :completed, classroom_id: classrooms(:two).id, format: :csv
    csv_array = CSV.parse @response.body

    assert_equal ["user", "question", "answer", "created_at", "helped_at", "done_at", ], csv_array[0]
    assert :success
  end

  test "should get requests containing query" do
    classrooms(:two).requests.create(question: 'question about jerky', owner_id: users(:student1).id)
    get :search, classroom_id: classrooms(:two).id, query: 'jerky'

    assert_equal 1, assigns(:requests).count(:all)
    assert :success
  end

  test "should create request with valid data" do
    assert_difference 'Request.count' do
      @params[:format] = :json
      xhr :post, :create, @params
    end

    assert_equal 'waiting', Request.last.state
    assert_equal @params[:request][:question], Request.last.question
    assert_equal users(:student1).id, Request.last.owner_id
  end

  test "should update request question and answer" do
    xhr :patch, :update, classroom_id: classrooms(:two), id: requests(:one).id , request: {question: 'new question', answer: 'with an answer'}

    assert_equal 'new question', requests(:one).reload.question
    assert_equal 'with an answer', requests(:one).reload.answer
  end

  test "should toggle request state from waiting to being helped" do
    xhr :patch, :toggle_help, classroom_id: classrooms(:two), id: requests(:one).id

    assert_equal 'being_helped', requests(:one).reload.state
  end

  test "should toggle request state from being helped to waiting" do
    sign_out users(:student1)
    sign_in users(:student2)
    xhr :patch, :toggle_help, classroom_id: classrooms(:two), id: requests(:two).id

    assert_equal 'waiting', requests(:two).reload.state
  end

  test "should remove request when it's done" do
    sign_out users(:student1)
    sign_in users(:teacher1)
    xhr :patch, :remove, classroom_id: classrooms(:two), id: requests(:two).id

    assert_equal 'done', requests(:two).reload.state
  end

  test "should delete request" do
    assert_difference 'classrooms(:two).requests.count', -1 do
      xhr :delete, :destroy, classroom_id: classrooms(:two), id: requests(:one).id
    end
  end

  test "teacher should be able to delete request" do
    sign_out users(:student1)
    sign_in users(:teacher1)
    assert_difference 'classrooms(:two).requests.count', -1 do
      xhr :delete, :destroy, classroom_id: classrooms(:two), id: requests(:one).id
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
