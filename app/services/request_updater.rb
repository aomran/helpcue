class RequestUpdater

  attr_accessor :request, :update_action
  def initialize(request)
    @request = request
  end

  def update_state(state_action)
    if state_action == 'toggle_state'
      request.toggle_state
      @update_action = 'updateRequest'
    elsif state_action == 'remove'
      request.remove_from_queue
      @update_action = 'removeRequest'
    end
    self
  end

  def update_content(safe_params)
    request.update(safe_params)
    if safe_params[:question]
      @update_action = 'updateQuestion'
    elsif safe_params[:answer]
      @update_action = 'updateAnswer'
    end
    self
  end

  def add_or_remove_user(current_user)
    if current_user.requests.exclude?(request)
      current_user.requests << request
    else
      current_user.requests.delete(request)
    end
    self
  end
end
