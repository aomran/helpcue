class RemoveStatusFromRequest < ActiveRecord::Migration
  def change
    remove_column :requests, :status, :string
  end
end
