class AddDefaultStatusToRequests < ActiveRecord::Migration
  def change
    change_column_default :requests, :status, Request::STATUS_OPTIONS[0]
  end
end
