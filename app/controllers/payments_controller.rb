class PaymentsController < ApplicationController

	def create
		@product = Product.find(params[:product_id])
		@total_price = unit_price * quantity
		@total_price = params[:total_price]

# STRIPE, creating charges
		# Set your secret key: remember to change this to your live secret key in production
		# See your keys here https://dashboard.stripe.com/account/apikeys
		Stripe.api_key = "sk_test_goDPpEFtbnzOsqWXOwXkUzMY"

		# Get the credit card details submitted by the form
		token = params[:stripeToken]

		# Create the charge on Stripe's servers - this will charge the user's card
		begin
			charge = Stripe::Charge.create(
			:amount => "@product.price", # amount in cents, again
			:currency => "usd",
			:source => token,
			:description => params[:stripeEmail]
			)

			if charge.paid
				Order.create(:product_id => '@product_id',
					:user_id => 'current_user',
					:total_price => '@total_price'
			)
			end

			rescue Stripe::CardError => e
			# The card has been declined
			body = e.json_body
    		err = body[:error]
    		flash[:error] = "Unfortunately, there was an error processing your payment: #{err[:message]}"
		end
		redirect_to product_path(@product)
# STRIPE, creating charges


	end

	def show
	end



end
