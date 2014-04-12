class Request < ActiveRecord::Base
  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :question

  has_and_belongs_to_many :users
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  belongs_to :classroom

  scope :need_help, -> { where.not(status: STATUS_OPTIONS[2]).order("created_at ASC") }
  scope :completed, -> { where(status: STATUS_OPTIONS[2]).order("updated_at DESC") }
  STATUS_OPTIONS = ['Waiting', 'Being Helped', 'Done']
end
