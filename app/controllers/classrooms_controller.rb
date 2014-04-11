class ClassroomsController < ApplicationController

  after_action :verify_authorized, only: [:edit, :update]
  before_action :get_classroom, only: [:edit, :update, :destroy]

  def index
    @classrooms = current_user.classrooms
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

  def edit
    authorize @classroom

    @students = @classroom.users.merge(@classroom.classroom_users.students)
    @teachers = @classroom.users.merge(@classroom.classroom_users.teachers)
  end

  def update
    authorize @classroom

    if @classroom.update(classroom_params)
      redirect_to classroom_path(@classroom), notice: "Classroom has been updated."
    else
      render :edit
    end
  end

  def destroy
    current_user.classrooms.delete(@classroom)
    if @classroom.users.empty?
      @classroom.destroy
    end
    redirect_to classrooms_path, notice: "You have left the classroom."
  end

  def join
    if classroom = Classroom.find_by(user_token: params[:join_token])
      role = 'User'
    elsif classroom = Classroom.find_by(admin_token: params[:join_token])
      role = 'Admin'
    end

    respond_to do |format|
      if classroom && current_user.classrooms.exclude?(classroom)
        classroom.classroom_users.create(user: current_user, role: role)
        format.json { render json: { partial: render_to_string(partial: 'classroom.html', locals: { classroom: classroom }), id: classroom.id, role: role }, status: :created, location: classroom }
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