class Request < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  belongs_to :classroom

  scope :need_help, -> { where.not(status: STATUS_OPTIONS[2]).order(" updated_at ASC") }
  STATUS_OPTIONS = ['Waiting', 'Being Helped', 'Done']
end
