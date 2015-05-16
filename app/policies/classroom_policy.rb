class ClassroomPolicy < ApplicationPolicy

  def update?
    user.admin_or_mentor?(record)
  end

  def admin?
    user.admin?(record)
  end

  def owner?
    user.owner?(record)
  end
end
