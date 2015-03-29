class Request < ActiveRecord::Base
  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :question

  has_and_belongs_to_many :users
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  belongs_to :classroom

  scope :need_help, -> { where.not(state: 2).order("created_at ASC") }
  scope :completed, -> { where(state: 2).order("updated_at DESC") }

  enum state: [:waiting, :being_helped, :done]

  validates :question, length: { maximum: 255 }

  include PgSearch
  pg_search_scope :search, against: [:question, :answer],
    using: {tsearch: {dictionary: "english"}},
    associated_against: {
      users: [:first_name, :last_name],
      owner: [:first_name, :last_name]
    }

  def toggle_state
    if waiting?
      being_helped!
      self.helped_at = Time.zone.now
    elsif being_helped?
      waiting!
    end
    self
  end

  def remove_from_queue
    done!
    self.done_at = Time.zone.now
    self
  end

  def time_waiting
    helped_at ? (helped_at - created_at).ceil : 0
  end

  def help_duration
    (helped_at && done_at) ? (done_at - helped_at).ceil : 0
  end

  def self.to_csv(admin)
    if admin
      csv_header = ["user", "question", "answer", "created_at", "helped_at", "done_at"]
    elsif !admin
      csv_header = ["user", "question", "answer", "created_at"]
    end

    CSV.generate do |csv|
      csv << csv_header
      all.each do |request|
        csv << request.attributes.values_at(*csv_header[1..-1]).unshift(request.owner.full_name)
      end
    end
  end
end
