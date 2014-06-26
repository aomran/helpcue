class UsersController < ApplicationController

  before_action :get_classroom
  before_action :get_user, except: [:index]
  after_action :verify_authorized

  def index
    authorize @classroom, :people?
    @users = @classroom.users.order('classroom_users.role, first_name')
  end

  def update
    authorize @classroom, :promote?
    role = @user.promote_or_demote(@classroom, params[:promote]).role

    respond_to do |format|
      format.json {
        render json: {role: role, id: @user.id} , status: :ok
      }
    end
  end

  def destroy
    if @user.admin?(@classroom)
      authorize @classroom, :remove_admin?
    else
      authorize @classroom, :remove_student?
    end
    @classroom.users.delete(@user)

    respond_to do |format|
      format.json {
        render json: { id: params[:id] }
      }
    end
  end

  private
  def get_user
    @user = @classroom.users.find(params[:id])
  end
end
