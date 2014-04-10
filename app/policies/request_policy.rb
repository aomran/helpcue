class RequestPolicy
  attr_reader :user, :request

  def initialize(user, request)
    @user = user
    @request = request
  end

  def update?
    (request.owner == user) || user.admin?(request.classroom)
  end

  def toggle_help?
    (request.owner == user) || user.admin?(request.classroom)
  end

  def remove?
    (request.owner == user) || user.admin?(request.classroom)
  end

  def destroy?
    (request.owner == user) || user.admin?(request.classroom)
  end

  def me_too?
    (request.owner != user) && !user.admin?(request.classroom)
  end
end