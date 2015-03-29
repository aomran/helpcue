class ClassroomPolicy
  attr_reader :user, :classroom

  def initialize(user, classroom)
    @user = user
    @classroom = classroom
  end

  def update?
    user.admin_or_mentor?(classroom)
  end

  def admin?
    user.admin?(classroom)
  end

  def owner?
    user.owner?(classroom)
  end
end
