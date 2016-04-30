class User < ActiveRecord::Base
# Include default devise modules. Others available are:
# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	 :recoverable, :rememberable, :trackable, :validatable
	has_many :orders

	has_many :comments

# VALIDATION
   	validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
# VALIDATION

# SEND SIGN-UP EMAIL
	after_create :send_signup_email
	def send_signup_email
		UserMailer.send_signup_email(self).deliver_now 
	end
# SEND SIGN-UP EMAIL

end
