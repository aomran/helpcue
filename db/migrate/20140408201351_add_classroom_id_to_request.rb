class AddClassroomIdToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :classroom_id, :integer
  end
end
