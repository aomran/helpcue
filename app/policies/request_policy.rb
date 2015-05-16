class RequestPolicy < ApplicationPolicy

  def update?
    user.owner?(record) || user.admin_or_mentor?(record.classroom)
  end

  def toggle_help?
    !record.done? && update?
  end

  def remove?
    record.being_helped? && update?
  end

  def destroy?
    record.waiting? && update?
  end

  def me_too?
    !record.done? && !update?
  end
end
