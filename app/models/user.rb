class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  before_save :set_avatar

  has_many :classroom_users
  has_many :classrooms, through: :classroom_users
  has_many :owned_classrooms, :class_name => "Classroom", :foreign_key => "owner_id"

  private
  def set_avatar
    email_address = self.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    self.avatar = "http://www.gravatar.com/avatar/#{hash}"
  end
end
