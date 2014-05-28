class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2]

  validates :first_name, presence: true
  validates :last_name, presence: true

  before_save :set_avatar

  has_many :classroom_users
  has_many :classrooms, through: :classroom_users
  has_many :owned_classrooms, :class_name => "Classroom", :foreign_key => "owner_id"
  has_and_belongs_to_many :requests
  has_many :owned_requests, :class_name => "Request", :foreign_key => "owner_id"


  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?(classroom)
    self.classroom_users.where(classroom: classroom, role: 'Admin').any?
  end

  def promote_or_demote(classroom, promote)
    classroom_user = self.classroom_users.where(classroom: classroom).first
    if promote
      classroom_user.role = 'Admin'
    elsif !promote
      classroom_user.role = 'User'
    end
    classroom_user.save
    classroom_user
  end

  def self.full_names
    all.collect {|u| u.full_name }.join(', ')
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.create(
         email: data["email"],
         first_name: data['first_name'],
         last_name: data['last_name'],
         password: Devise.friendly_token[0,20],
         provider: access_token.provider,
         uid: access_token.uid
      )
    end
    user
  end

  private
  def set_avatar
    email_address = self.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    self.avatar = "http://www.gravatar.com/avatar/#{hash}"
  end
end
