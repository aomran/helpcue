class ClassroomPolicy
  attr_reader :user, :classroom

  def initialize(user, classroom)
    @user = user
    @classroom = classroom
  end

  def edit?
    classroom.owner == user
  end

  def update?
    classroom.owner == user
  end
end