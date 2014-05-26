class ChangeDefaultSortType < ActiveRecord::Migration
  def change
    change_column :classrooms, :sort_type, :string, default: 'Time'
    Classroom.where(sort_type: 'time').update_all(sort_type: 'Time')
    Classroom.where(sort_type: 'popularity').update_all(sort_type: 'Popularity')
  end
end
