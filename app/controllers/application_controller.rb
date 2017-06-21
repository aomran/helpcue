class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  layout :layout_by_resource
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  def layout_by_resource
    if devise_controller? && !user_signed_in?
      "login_layout"
    else
      "application"
    end
  end

  private
  def get_classroom
    @classroom = current_user.classrooms.find(params[:classroom_id] || params[:id])
    MessageBus.group_ids_lookup { |env| [@classroom.id] }
    @classroom
  end

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def push_to_channel(requestAction, data={})
    data = { requestAction: requestAction, user_id: current_user.id, classroom_id: @classroom.id }.merge(data)
    if @request
      data = data.merge({request_id: params[:id] || @request.id})
    end
    MessageBus.publish "/request", data, group_ids: [@classroom.id]
  end
end
