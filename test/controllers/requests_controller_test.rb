require 'test_helper'

class RequestsControllerTest < ActionController::TestCase
  def setup
    MessageBus.stubs(:publish)
    sign_in users(:student1)
    @params = {
      classroom_id: classrooms(:two),
      request: {
        question: 'I am a #question'
      }
    }
  end

  test "should get list of requests" do
    get :index, params: {classroom_id: classrooms(:two).id}

    assert :success
  end

  test "should get list of requests in JSON" do
    get :index, xhr: true, format: :json, params: {classroom_id: classrooms(:two).id}

    assert_equal classrooms(:two).requests.need_help.count, json['requests'].length
  end

  test "should get list of completed requests" do
    get :completed, params: {classroom_id: classrooms(:two).id}

    assert :success
  end

  test "user export csv" do
    get :completed, params: {classroom_id: classrooms(:two).id}, format: :csv
    csv_array = CSV.parse @response.body

    assert_equal ["user", "question", "answer", "created_at"], csv_array[0]
    assert :success
  end

  test "admin export csv" do
    sign_out users(:student1)
    sign_in users(:teacher1)

    get :completed, params: {classroom_id: classrooms(:two).id}, format: :csv
    csv_array = CSV.parse @response.body

    assert_equal ["user", "question", "answer", "created_at", "helped_at", "done_at", ], csv_array[0]
    assert :success
  end

  test "should get requests containing query" do
    classrooms(:two).requests.create(question: 'question about jerky', owner_id: users(:student1).id)
    get :search, params: {classroom_id: classrooms(:two).id, query: 'jerky'}

    assert :success
  end

  test "should return an html partial for request" do
    get :show, xhr: true, params: {classroom_id: classrooms(:two).id, id: requests(:one).id}

    assert json["partial"], 'Partial was not sent in response body'
  end

  test "should create request with valid data" do
    assert_difference 'Request.count' do
      post :create, params: @params, format: :json, xhr: true
    end

    response_body = JSON.parse(response.body)

    assert_equal 'waiting', response_body['state']
    assert_equal @params[:request][:question], response_body['question']
    assert_equal users(:student1).id, response_body['owner_id']
  end

  test "should update request question and answer" do
    patch :update, xhr: true, params: {classroom_id: classrooms(:two), id: requests(:one).id , request: {question: 'new question', answer: 'with an answer'}}

    assert_equal 'new question', requests(:one).reload.question
    assert_equal 'with an answer', requests(:one).reload.answer
  end

  test "should toggle request state from waiting to being helped" do
    patch :update, xhr: true, params: {classroom_id: classrooms(:two), id: requests(:one).id, state_action: 'toggle_state'}

    assert_equal 'being_helped', requests(:one).reload.state
  end

  test "should toggle request state from being helped to waiting" do
    sign_out users(:student1)
    sign_in users(:student2)
    patch :update, xhr: true, params: {classroom_id: classrooms(:two), id: requests(:two).id, state_action: 'toggle_state'}

    assert_equal 'waiting', requests(:two).reload.state
  end

  test "should remove request when it's done" do
    sign_out users(:student1)
    sign_in users(:teacher1)
    patch :update, xhr: true, params: {classroom_id: classrooms(:two), id: requests(:two).id, state_action: 'remove'}

    assert_equal 'done', requests(:two).reload.state
  end

  test "should delete request" do
    assert_difference 'classrooms(:two).requests.count', -1 do
      delete :destroy, xhr: true, params: {classroom_id: classrooms(:two), id: requests(:one).id}
    end
  end

  test "teacher should be able to delete request" do
    sign_out users(:student1)
    sign_in users(:teacher1)
    assert_difference 'classrooms(:two).requests.count', -1 do
      delete :destroy, xhr: true, params: {classroom_id: classrooms(:two), id: requests(:one).id}
    end
  end

  test "should add additional student to request" do
    sign_out users(:student1)
    sign_in users(:student2)
    assert_difference 'requests(:one).users.count' do
      patch :me_too, xhr: true, params: {classroom_id: classrooms(:two), id: requests(:one).id}
    end
  end

  test "should add additional student to request only once, instead removing them" do
    sign_out users(:student1)
    sign_in users(:student2)
    patch :me_too, xhr: true, params: {classroom_id: classrooms(:two), id: requests(:one).id}

    assert_difference 'requests(:one).users.count', -1 do
      patch :me_too, xhr: true, params: {classroom_id: classrooms(:two), id: requests(:one).id}
    end
  end

  test "should not allow teacher to me-too a request" do
    sign_out users(:student1)
    sign_in users(:teacher1)

    assert_no_difference 'requests(:one).users.count' do
      patch :me_too, xhr: true, params: {classroom_id: classrooms(:two), id: requests(:one).id}
    end

    assert "You are not authorized to perform this action.", flash[:error]
  end
end
