class AddColumnToClassroom < ActiveRecord::Migration
  def change
    add_column :classrooms, :sort_type, :string, default: 'time'
  end
end
