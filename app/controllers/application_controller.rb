class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

# SHOPPING CART
  helper_method :current_order

  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end
# SHOPPING CART

# DEVISE Since devise default saves only email and password, add this block to add first_name and last_name.
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation) }
  	devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:first_name, :last_name, :email, :password) }
  	devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation) }
  end
# DEVISE Since devise default saves only email and password, add this block to add first_name and last_name.

# CANCAN Directs page to root url when attempt access unauthorized page
	rescue_from CanCan::AccessDenied do |exception|
	redirect_to main_app.root_url, :alert => exception.message
# CANCAN Directs page to root url when attempt access unauthorized page

end

end