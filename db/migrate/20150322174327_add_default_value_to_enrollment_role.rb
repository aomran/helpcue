class AddDefaultValueToEnrollmentRole < ActiveRecord::Migration
  def change
    change_column_default :enrollments, :role, 'Member'
  end
end
