class UsersController < ApplicationController

  before_action :get_classroom
  before_action :get_user, only: [:destroy]
  after_action :verify_authorized, only: [:destroy]

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
