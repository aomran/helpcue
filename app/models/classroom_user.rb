class ClassroomUser < ActiveRecord::Base
  belongs_to :classroom
  belongs_to :user
end
