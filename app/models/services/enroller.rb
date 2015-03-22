class Enroller

  attr_accessor :classroom, :user, :errors

  def initialize(classroom, user)
    @classroom = classroom
    @user = user
    @errors = []
  end

  def save
    if classroom && user.classrooms.exclude?(classroom)
      classroom.enrollments.create(user: user)
      true
    else
      if user.classrooms.include?(classroom)
        @errors << 'You are already in this classroom'
      else
        @errors << 'Invalid Token'
      end
      false
    end
  end

end
