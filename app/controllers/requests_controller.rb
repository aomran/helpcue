class RequestsController < ApplicationController
  before_action :get_classroom
  before_action :get_request, only: [:update, :toggle_help, :remove, :destroy, :me_too, :show]
  after_action :verify_authorized, only: [:update, :toggle_help, :remove, :destroy, :me_too]

  def index
    @requests = @classroom.requests.need_help
    @request = Request.new
  end

  def completed
    @requests = @classroom.requests.completed.page(params[:page])

    respond_to do |format|
      format.json {
        render json: { partial: render_to_string(partial: 'requests.html'), pagination_partial: render_to_string(partial: 'requests_pagination.html') }
      }
      format.html {}
    end
  end

  def search
    @requests = @classroom.requests.search(params[:query]).page(params[:page])


    respond_to do |format|
      format.json {
        render json: { partial: render_to_string(partial: 'requests.html'), pagination_partial: render_to_string(partial: 'requests_pagination.html') }
      }
      format.html {
        @total_results_count = @requests.total_count
        flash.now[:track] = { event_name: "Search", properties: { classroom_id: @classroom.id, query: params[:query], results_count: @total_results_count } }
      }
    end
  end

  def show
    respond_to do |format|
      format.json {
        render json: { partial: render_to_string(partial: 'request.html', locals: { classroom: @classroom, request: @request }) }
      }
    end
  end

  def create
    @request = @classroom.requests.build(question: params[:request][:question])
    @request.status = Request::STATUS_OPTIONS[0]
    @request.owner = current_user

    respond_to do |format|
      if @request.save
        push_to_channel('addRequest')
        update_requesters_number(true)
        format.json { render json: { classroom_id: @classroom.id, request_id: @request.id, question_length: @request.question.length }, status: :created }
      else
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @request
    respond_to do |format|
      if @request.update(request_params)
        push_to_channel('updateRequest')
        format.json { render json: { classroom_id: @classroom.id, request_id: @request.id }, status: :created }
      else
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def me_too
    authorize @request

    if current_user.requests.exclude?(@request)
      me_too_status = 'joined'
      current_user.requests << @request
    else
      current_user.requests.delete(@request)
      me_too_status = 'left'
    end

    respond_to do |format|
      push_to_channel('updateRequest')
      format.json {
        render json: { classroom_id: @classroom.id, request_id: @request.id, me_too_status: me_too_status, count: @request.users.count }
      }
    end
  end

  def toggle_help
    authorize @request
    if @request.status == Request::STATUS_OPTIONS[0]
      @request.status = Request::STATUS_OPTIONS[1]
    elsif @request.status == Request::STATUS_OPTIONS[1]
      @request.status = Request::STATUS_OPTIONS[0]
    end

    respond_to do |format|
      if @request.save
        push_to_channel('updateRequest')
        format.json { render json: { classroom_id: @classroom.id, request_id: @request.id, request_status: @request.status }, status: :created }
      else
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove
    authorize @request
    @request.status = Request::STATUS_OPTIONS[2]
    respond_to do |format|
      if @request.save
        push_to_channel('removeRequest')
        update_requesters_number(false)
        format.json { render json: { classroom_id: @classroom.id, request_id: @request.id, request_status: @request.status }, status: :created }
      else
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @request
    @request.destroy

    respond_to do |format|
      push_to_channel('removeRequest')
      update_requesters_number(false)
      format.json {
        render json: { request_id: params[:id] }
      }
    end
  end

  private
  def request_params
    params.require(:request).permit(:question, :status)
  end
  def get_request
    @request = @classroom.requests.find(params[:id])
  end

  def push_to_channel(requestAction)
    data = { requestAction: requestAction, request_id: params[:id] || @request.id, user_id: current_user.id, classroom_id: @classroom.id }
    Pusher.trigger("classroom#{@classroom.id}-requests", 'request', data)
  end

  def update_requesters_number(add)
    Pusher.trigger("classroom#{@classroom.id}-requests", 'requestUpdate', {add: add })
  end
end
