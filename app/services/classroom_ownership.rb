class ClassroomOwnership

  attr_accessor :classroom, :owner

  def initialize(classroom, owner)
    @classroom = classroom
    @owner = owner
    classroom.owner_id = owner.id
  end

  def save
    if classroom.save
      classroom.enrollments.create(user: owner, role: Enrollment::ROLES[0])
      true
    else
      false
    end
  end

end
