class ClassroomPolicy
  attr_reader :user, :classroom

  def initialize(user, classroom)
    @user = user
    @classroom = classroom
  end

  def update?
    user.admin?(classroom) # Admin, Mentor
  end

  def admin?
    user.role(classroom) == Enrollment::ROLES[0] # Admin
  end

  def owner?
    classroom.owner == user # Owner
  end
end
