class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.string :name
      t.string :description
      t.string :admin_token
      t.string :user_token
      t.integer :owner_id

      t.timestamps
    end
  end
end
