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

  def set_sort?
    user.admin?(classroom)
  end

  def people?
    user.admin?(classroom)
  end

  def remove_student?
    user.admin?(classroom)
  end

  def promote?
    classroom.owner == user || user.role(classroom) == Classroom::ROLES[0]
  end

  def remove_admin?
    classroom.owner == user || user.role(classroom) == Classroom::ROLES[0]
  end
end