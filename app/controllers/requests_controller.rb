class RequestsController < ApplicationController
  before_action :get_classroom
  before_action :get_request, only: [:update, :toggle_help, :remove, :destroy, :me_too, :show]
  after_action :verify_authorized, only: [:update, :toggle_help, :remove, :destroy, :me_too]

  def index
    @requests = @classroom.requests.need_help.includes(:owner)
  end

  def completed
    @requests = @classroom.requests.completed.page(params[:page]).includes(:owner, :classroom)

    respond_to do |format|
      format.json { render json: pagination_partial_json }
      format.html {}
      format.csv { send_data @classroom.requests.completed.to_csv(current_user.admin_or_mentor?(@classroom)) }
    end
  end

  def search
    @requests = @classroom.requests.search(params[:query]).page(params[:page]).includes(:owner)
    @total_results_count = @requests.total_count

    respond_to do |format|
      format.json { render json: pagination_partial_json }
      format.html {}
    end
  end

  def show
    render json: { partial: render_to_string(partial: 'request.html', locals: { classroom: @classroom, request: @request.decorate }), expand_partial: render_to_string(partial: 'request_more.html', locals: { classroom: @classroom, request: @request }) }
  end

  def create
    @request = @classroom.requests.build(question: params[:request][:question])
    @request.owner = current_user
    @request_action = 'addRequest'

    if @request.save
      push_to_channel(@request_action)
      render :show, status: :created
    else
      render json: @request.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @request
    request_updater = RequestUpdater.new(@request)
    if params[:state_action]
      request_updater.update_state(params[:state_action])
    else
      request_updater.update_content(request_params)
    end
    @request_action = request_updater.update_action

    if @request.save
      push_to_channel(@request_action, question: @request.question, answer: @request.answer)
      render :show, status: :ok
    else
      render json: @request.errors, status: :unprocessable_entity
    end

  end

  def me_too
    authorize @request
    request_updater = RequestUpdater.new(@request).add_or_remove_user(current_user)

    push_to_channel('updateRequest')
    render :show, status: :ok
  end

  def destroy
    authorize @request
    @request.destroy

    push_to_channel('removeRequest')
    render json: { request_id: params[:id] }
  end

  private
  def request_params
    params.require(:request).permit(:question, :answer)
  end
  def get_request
    @request = @classroom.requests.find(params[:id])
  end
  def pagination_partial_json
    { partial: render_to_string(partial: 'requests.html'), pagination_partial: render_to_string(partial: 'requests_pagination.html') }
  end
end
