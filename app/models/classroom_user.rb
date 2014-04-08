class ClassroomUser < ActiveRecord::Base
  belongs_to :classroom
  belongs_to :user

  scope :teachers, -> { where(role: 'Admin') }
  scope :students, -> { where(role: 'User') }
end
