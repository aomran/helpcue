class AddAnswerToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :answer, :text
  end
end
