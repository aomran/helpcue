class RemoveColumnFromClassrooms < ActiveRecord::Migration
  def change
    remove_column :classrooms, :admin_token, :string
  end
end
