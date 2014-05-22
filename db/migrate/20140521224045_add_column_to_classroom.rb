class AddColumnToClassroom < ActiveRecord::Migration
  def change
    add_column :classroom_users, :sort_type, :string, default: 'time'
  end
end
