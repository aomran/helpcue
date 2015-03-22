class RenameClassroomUserToEnrollment < ActiveRecord::Migration
  def self.up
    rename_table :classroom_users, :enrollments
  end

 def self.down
    rename_table :enrollments, :classroom_users
 end
end
