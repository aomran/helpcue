class AddStateToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :state, :integer, default: 0
  end
end
