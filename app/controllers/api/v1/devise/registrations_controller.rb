class API::V1::Devise::RegistrationsController < Devise::RegistrationsController

  def create
    user = User.new(params[:user])
    if user.save
      render :json=> user.as_json(:auth_token=>user.authentication_token, :email=>user.email), :status=>201
      return
    else
      warden.custom_failure!
      render :json=> user.errors, :status=>422
    end
  end

  def update
    @user = User.find(current_user.id)

    successfully_updated = if params[:user][:password].present?
      @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
    else
      # remove the virtual current_password attribute
      # update_without_password doesn't know how to ignore it
      params[:user].delete(:current_password)
      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    end

    if successfully_updated
      render :json=> user.as_json(:auth_token=>user.authentication_token, :email=>user.email), :status=>201
    else
      render :json=> user.errors, :status=>422
    end
  end
end