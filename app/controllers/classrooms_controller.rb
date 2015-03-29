class ClassroomsController < ApplicationController

  after_action :verify_authorized, only: [:update, :set_sort]
  before_action :get_classroom, only: [:update, :destroy, :set_sort]

  def index
    @classrooms = current_user.classrooms
  end

  def create
    @classroom = Classroom.new(classroom_params)
    ownership = ClassroomOwnership.new(@classroom, current_user)

    if ownership.save
      render json: classroom_partial_json, status: :created, location: @classroom
    else
      render json: @classroom.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @classroom

    if @classroom.update(classroom_params)
      render json: classroom_partial_json, status: :created, location: @classroom
    else
      render json: @classroom.errors, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.classrooms.delete(@classroom)
    @classroom.destroy if @classroom.users.empty?

    render json: { id: params[:id] }
  end

  def join
    @classroom = Classroom.find_by(user_token: params[:join_token].strip)
    enroller = Enroller.new(@classroom, current_user)

    if enroller.save
      render json: classroom_partial_json, status: :created, location: @classroom
    else
      render json: enroller.errors[0], status: :unprocessable_entity
    end
  end

  def set_sort
    authorize @classroom, :update?

    @classroom.sort_type = params[:sort_type]
    @classroom.save

    push_to_channel('updateSort', sortType: @classroom.sort_type)
    render json: { sort_type: @classroom.sort_type }
  end

  private
  def classroom_params
    params.require(:classroom).permit(:name, :description)
  end
  def classroom_partial_json
    { partial: render_to_string(partial: 'classroom.html', locals: { classroom: @classroom }), id: @classroom.id }
  end
end
