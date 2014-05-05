class Classroom < ActiveRecord::Base
  has_many :requests
  has_many :classroom_users
  has_many :users, through: :classroom_users
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"

  validates :name, presence: {message: "You must name the classroom!"}
  validates_length_of :name, :maximum => 90
  validates_length_of :description, :maximum => 90, :allow_blank => true

  before_create :generate_tokens

  def students
    users.merge(classroom_users.students)
  end

  def teachers
    users.merge(classroom_users.teachers)
  end

  private
  def generate_tokens
    begin
      self.admin_token = SecureRandom.urlsafe_base64(6)
    end while Classroom.exists?(admin_token: self.admin_token)

    begin
      self.user_token = SecureRandom.urlsafe_base64(6)
    end while Classroom.exists?(user_token: self.user_token)
  end
end
