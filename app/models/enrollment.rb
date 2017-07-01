class Enrollment < ApplicationRecord
  belongs_to :classroom
  belongs_to :user

  ROLES = ['Admin', 'Mentor', 'Member']

  scope :admins, -> { where(role: ROLES[0]).map(&:user) }
  scope :mentors, -> { where(role: ROLES[1]).map(&:user) }
  scope :members, -> { where(role: ROLES[2]).map(&:user) }

  def self.for(classroom)
    where(classroom: classroom).first
  end
end
