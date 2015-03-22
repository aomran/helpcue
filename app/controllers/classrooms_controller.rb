class ClassroomsController < ApplicationController

  after_action :verify_authorized, only: [:update, :set_sort]
  before_action :get_classroom, only: [:update, :destroy, :set_sort]

  def index
    @classrooms = current_user.classrooms
  end

  def create
    @classroom = Classroom.new(classroom_params)
    ownership = ClassroomOwnership.new(@classroom, current_user)

    respond_to do |format|
      format.json do
        if ownership.save
          render json: { partial: render_to_string(partial: 'classroom.html', locals: { classroom: @classroom }), id: @classroom.id }, status: :created, location: @classroom
        else
          render json: @classroom.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    authorize @classroom

    respond_to do |format|
      format.json do
        if @classroom.update(classroom_params)
          render json: { partial: render_to_string(partial: 'classroom.html', locals: { classroom: @classroom }), id: @classroom.id }, status: :created, location: @classroom
        else
          render json: @classroom.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    current_user.classrooms.delete(@classroom)
    @classroom.destroy if @classroom.users.empty?

    respond_to do |format|
      format.json { render json: { id: params[:id] } }
    end
  end

  def join
    classroom = Classroom.find_by(user_token: params[:join_token].strip)
    enroller = Enroller.new(classroom, current_user)

    respond_to do |format|
      format.json do
        if enroller.save
          render json: { partial: render_to_string(partial: 'classroom.html', locals: { classroom: classroom }), id: classroom.id }, status: :created, location: classroom
        else
          render json: enroller.errors[0], status: :unprocessable_entity
        end
      end
    end
  end

  def set_sort
    authorize @classroom, :update?

    @classroom.sort_type = params[:sort_type]
    @classroom.save

    push_to_channel('updateSort')
    respond_to do |format|
      format.json {
        render json: { sort_type: @classroom.sort_type }
      }
    end
  end

  private
  def classroom_params
    params.require(:classroom).permit(:name, :description)
  end

  def push_to_channel(requestAction)
    Pusher.trigger("classroom#{@classroom.id}-requests", 'request', requestAction: requestAction, sortType: @classroom.sort_type, user_id: current_user.id)
  end
end
