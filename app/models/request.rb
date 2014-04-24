class Request < ActiveRecord::Base
  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :question

  has_and_belongs_to_many :users
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  belongs_to :classroom

  scope :need_help, -> { where.not(status: STATUS_OPTIONS[2]).order("created_at ASC") }
  scope :completed, -> { where(status: STATUS_OPTIONS[2]).order("updated_at DESC") }
  STATUS_OPTIONS = ['Waiting', 'Being Helped', 'Done']

  include PgSearch
  pg_search_scope :search, against: [:question],
    using: {tsearch: {dictionary: "english"}},
    associated_against: {
      users: [:first_name, :last_name],
      owner: [:first_name, :last_name]
    }

  def toggle_status
    if status == STATUS_OPTIONS[0]
      self.status = STATUS_OPTIONS[1]
      self.helped_at = Time.zone.now
    elsif status == STATUS_OPTIONS[1]
      self.status = STATUS_OPTIONS[0]
    end
    self
  end

  def remove_from_queue
    self.status = STATUS_OPTIONS[2]
    self.done_at = Time.zone.now
    self
  end

  def time_waiting
    if helped_at
      (helped_at - created_at).floor
    else
      0
    end
  end

  def help_duration
    if helped_at && done_at
      (done_at - helped_at).floor
    else
      0
    end
  end
end
