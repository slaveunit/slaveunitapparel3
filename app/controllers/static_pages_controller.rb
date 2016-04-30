class StaticPagesController < ApplicationController

  # for the CAROUSEL
  def index
    @products = Product.all
    @featured_product = Product.third
  end

  def store
    @products = Product.all
  end

  def thank_you
  	@name = params[:name]
  	@email = params[:email]
  	@message = params[:message]
  	ActionMailer::Base.mail(:from => @email, 
  		:to => 'slav3unit@gmail.com', 
  		:subject => "Slave Unit Apparel Inquiry", 
  		:body => @message).deliver_now
  	UserMailer.contact_form(@email, @name, @message).deliver_now
  end  

end
