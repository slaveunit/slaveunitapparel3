class CartsController < ApplicationController

	def show
		@order_items = current_order.order_items # from SHOPPING CART
	end
		
end