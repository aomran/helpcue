class ClassroomRole

  attr_accessor :classroom, :user

  def initialize(classroom, user)
    @classroom = classroom
    @user = user
  end

  def sorted_users
    users = []
    users << classroom.admins.sort_by(&:first_name)
    users << classroom.mentors.sort_by(&:first_name)
    users << classroom.members.sort_by(&:first_name)
    users.flatten
  end
end
