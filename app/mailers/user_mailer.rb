class UserMailer < ApplicationMailer
	default from: "slav3unit@gmail.com"

	def contact_form(email, name, message)
	@message = message
		mail(:from => email,
			:to => 'slav3unit@gmail.com',
			:subject => "A new contact form message from #{name}")
	end



	def send_signup_email(user)
   		@user = user
   		mail(:to => user.email, :subject => "Slave Unit Apparel")
  	end



  def thank_you
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    UserMailer.contact_form(@email, @name, @message).deliver_now
  end
	
end
