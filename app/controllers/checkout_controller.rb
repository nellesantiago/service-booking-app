class CheckoutController < ApplicationController
  before_action :authenticate_user
  before_action :prevent_admin
  before_action :require_cart_items
  
  def index
    @booking = Booking.find(session[:booking_id])
    @order = Order.find(session[:order_id])
    @service_orders = @order.service_orders
  end
end
