class UsersController < ApplicationController

  before_action :get_classroom
  before_action :get_user, except: [:index]
  after_action :verify_authorized

  def index
    authorize @classroom, :update?
    @admins = @classroom.admins.sort_by(&:first_name)
    @mentors = @classroom.mentors.sort_by(&:first_name)
    @members = @classroom.members.sort_by(&:first_name)
  end

  def update
    if params[:role] == 'Owner'
      authorize @classroom, :owner?
      ClassroomOwnership.new(@classroom, @user).update
    else
      authorize @classroom, :admin?
      enrollment = @user.enrollments.for(@classroom)
      enrollment.role = params[:role]
      enrollment.save
    end

    respond_to do |format|
      format.json {
        render json: {role: params[:role], id: @user.id} , status: :ok
      }
    end
  end

  def destroy
    authorize_user_removal
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

  def authorize_user_removal
    if @user == @classroom.owner
      raise Pundit::NotAuthorizedError, "Cannot remove owner"
    elsif @user.admin?(@classroom)
      authorize @classroom, :admin?
    else
      authorize @classroom, :update?
    end
  end
end
