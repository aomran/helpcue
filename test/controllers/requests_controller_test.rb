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

  test "should create request with valid data" do
    assert_difference 'Request.count' do
      @params[:format] = :json
      xhr :post, :create, @params
    end

    assert_equal Request::STATUS_OPTIONS[0], Request.last.status
    assert_equal users(:student1).id, Request.last.owner_id
  end
end
