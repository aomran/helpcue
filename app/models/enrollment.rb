class Enrollment < ActiveRecord::Base
  belongs_to :classroom
  belongs_to :user

  ROLES = ['Admin', 'Mentor', 'Member']

  scope :admins, -> { where(role: ROLES[0]) }
  scope :mentors, -> { where(role: ROLES[1]) }
  scope :members, -> { where(role: ROLES[2]) }
end
