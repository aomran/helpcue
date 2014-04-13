class ClassroomPolicy
  attr_reader :user, :classroom

  def initialize(user, classroom)
    @user = user
    @classroom = classroom
  end

  def edit?
    user.admin?(classroom)
  end

  def update?
    user.admin?(classroom)
  end

  def remove_admin?
    classroom.owner == user
  end

  def remove_student?
    user.admin?(classroom)
  end
end