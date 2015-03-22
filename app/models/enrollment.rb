class Enrollment < ActiveRecord::Base
  belongs_to :classroom
  belongs_to :user

  scope :admins, -> { where(role: Classroom::ROLES[0]) }
  scope :mentors, -> { where(role: Classroom::ROLES[1]) }
  scope :members, -> { where(role: Classroom::ROLES[2]) }
end
