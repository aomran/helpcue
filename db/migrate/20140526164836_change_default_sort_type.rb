class ChangeDefaultSortType < ActiveRecord::Migration
  def change
    change_column :classrooms, :sort_type, :string, default: 'Time'
  end
end
