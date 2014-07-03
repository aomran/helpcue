class API::V1::Devise::SessionsController < Devise::SessionsController
  prepend_before_filter :require_no_authentication, :only => [:create]

  def create
    resource = User.find_for_database_authentication(:email => params[:user][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user][:password])
      render :json => {:success=>true, :auth_token=>resource.authentication_token, :email=>resource.email}
      return
    end
    invalid_login_attempt
  end

  protected
  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your email or password"}, :status => 401
  end
end
