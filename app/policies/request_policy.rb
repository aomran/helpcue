class RequestPolicy
  attr_reader :user, :request

  def initialize(user, request)
    @user = user
    @request = request
  end

  def update?
    owns_request_or_is_admin
  end

  def toggle_help?
    !request.done? && owns_request_or_is_admin
  end

  def remove?
    request.being_helped? && owns_request_or_is_admin
  end

  def destroy?
    request.waiting? && owns_request_or_is_admin
  end

  def me_too?
    !request.done? && not_admin_and_doesnt_own_request
  end

  protected
  def owns_request_or_is_admin
    user.owner?(request) || user.admin_or_mentor?(request.classroom)
  end

  def not_admin_and_doesnt_own_request
    !owns_request_or_is_admin
  end
end
