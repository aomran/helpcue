class Classroom < ActiveRecord::Base
  has_many :requests
  has_many :enrollments
  has_many :users, through: :enrollments
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"

  validates :name, presence: {message: "You must name the classroom!"}
  validates_length_of :name, :maximum => 90
  validates_length_of :description, :maximum => 90, :allow_blank => true

  before_create :generate_token
  SORT_TYPE = ['Time', 'Popularity']

  delegate :members, :admins, :mentors, to: :enrollments

  def sort_by_time?
    sort_type == SORT_TYPE[0]
  end

  def sort_by_popularity?
    sort_type == SORT_TYPE[1]
  end

  private
  def generate_token
    begin
      self.user_token = SecureRandom.urlsafe_base64(6)
    end while Classroom.exists?(user_token: self.user_token)
  end
end
