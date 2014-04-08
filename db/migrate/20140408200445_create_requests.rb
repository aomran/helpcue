class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :question
      t.string :status
      t.integer :owner_id

      t.timestamps
    end

    create_table :requests_users do |t|
      t.belongs_to :request
      t.belongs_to :user
    end
  end
end
