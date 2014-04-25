class AddTimesToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :helped_at, :datetime
    add_column :requests, :done_at, :datetime
  end
end
