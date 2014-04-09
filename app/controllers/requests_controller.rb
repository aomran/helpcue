class RequestsController < ApplicationController
  before_action :get_classroom
  before_action :get_request, only: [:update, :toggle_help, :remove, :destroy]
  after_action :verify_authorized, only: [:update, :toggle_help, :remove, :destroy]

  def index
    @requests = @classroom.requests.need_help
    @request = Request.new
  end

  def completed
    @requests = @classroom.requests.completed
  end

  def create
    @request = @classroom.requests.build(question: params[:request][:question])
    @request.status = Request::STATUS_OPTIONS[0]
    @request.owner = current_user

    respond_to do |format|
      if @request.save
        format.json { render json: { partial: render_to_string(partial: 'request.html', locals: { classroom: @classroom, request: @request }), classroom_id: @classroom.id, request_id: @request.id }, status: :created }
      else
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @request
    respond_to do |format|
      if @request.update(request_params)
        format.json { render json: { partial: render_to_string(partial: 'request.html', locals: { classroom: @classroom, request: @request }), classroom_id: @classroom.id, request_id: @request.id }, status: :created }
      else
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
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
      format.json {
        render json: { id: params[:id] }
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
end
