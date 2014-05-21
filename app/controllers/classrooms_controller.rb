class ClassroomsController < ApplicationController

  after_action :verify_authorized, only: [:edit, :update, :people]
  before_action :get_classroom, only: [:edit, :update, :destroy, :people]

  def index
    @classrooms = current_user.classrooms
  end

  def people
    authorize @classroom
    @teachers = @classroom.teachers
    @students = @classroom.students
  end

  def create
    @classroom = Classroom.new(classroom_params)
    @classroom.owner_id = current_user.id
    respond_to do |format|
      if @classroom.save
        @classroom.classroom_users.create(user: current_user, role: 'Admin')
        format.json { render json: { partial: render_to_string(partial: 'classroom.html', locals: { classroom: @classroom }), id: @classroom.id }, status: :created, location: @classroom }
      else
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @classroom

    respond_to do |format|
      if @classroom.update(classroom_params)
        format.json {
          render json: { partial: render_to_string(partial: 'classroom.html', locals: { classroom: @classroom }), id: @classroom.id }, status: :created, location: @classroom
        }
      else
        format.json {
          render json: @classroom.errors, status: :unprocessable_entity
        }
      end
    end
  end

  def destroy
    current_user.classrooms.delete(@classroom)
    if @classroom.users.empty?
      @classroom.destroy
    end
    respond_to do |format|
      format.json {
        render json: { id: params[:id] }
      }
    end
  end

  def join
    classroom = Classroom.find_by(user_token: params[:join_token].strip)

    respond_to do |format|
      if classroom && current_user.classrooms.exclude?(classroom)
        classroom.classroom_users.create(user: current_user, role: 'User')
        format.json { render json: { partial: render_to_string(partial: 'classroom.html', locals: { classroom: classroom }), id: classroom.id }, status: :created, location: classroom }
      else
        if current_user.classrooms.include?(classroom)
          message = 'You are already in this classroom'
        else
          message = 'Invalid Token'
        end
        format.json { render json: message, status: :unprocessable_entity }
      end
    end
  end

  private
  def classroom_params
    params.require(:classroom).permit(:name, :description)
  end
end