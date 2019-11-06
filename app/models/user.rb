class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	after_create :welcome_send
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  
	has_many :attendances
	has_many :events, through: :attendances
    has_many :organisations, foreign_key: 'admin_id', class_name: "Event"


  def welcome_send
  	UserMailer.welcome_email(self).deliver_now	
  end

end
