class AddDefaultStatusToRequests < ActiveRecord::Migration
  def change
    change_column_default :requests, :status, 'Waiting'
  end
end
