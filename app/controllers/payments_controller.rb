class PaymentsController < ApplicationController

	def create
		@order = current_order
		@user = current_user
# STRIPE, creating charges
		# Set your secret key: remember to change this to your live secret key in production
		# See your keys here https://dashboard.stripe.com/account/apikeys
		Stripe.api_key = "sk_test_goDPpEFtbnzOsqWXOwXkUzMY"

		# Get the credit card details submitted by the form
		token = params[:stripeToken]

		# Create the charge on Stripe's servers - this will charge the user's card
		begin
			charge = Stripe::Charge.create(
			:amount => 1000, # amount in cents, again
			:currency => "usd",
			:source => token,
			:description => params[:stripeEmail]
			)

			if charge.paid
				Order.create(
					:product_id => '@product_id',
					:product_size => '@product_size',
					:user_id => 'current_user',
					:total => 'data-amount'
			)
			end

			rescue Stripe::CardError => e
			# The card has been declined
			body = e.json_body
    		err = body[:error]
    		flash[:error] = "Unfortunately, there was an error processing your payment: #{err[:message]}"
		end
		redirect_to products_url
# STRIPE, creating charges


	end

	def show
	end



end
