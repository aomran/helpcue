class RequestPolicy
  attr_reader :user, :request

  def initialize(user, request)
    @user = user
    @request = request
  end

  def update?
    user.owner?(request) || user.admin_or_mentor?(request.classroom)
  end

  def toggle_help?
    !request.done? && update?
  end

  def remove?
    request.being_helped? && update?
  end

  def destroy?
    request.waiting? && update?
  end

  def me_too?
    !request.done? && !update?
  end
end
