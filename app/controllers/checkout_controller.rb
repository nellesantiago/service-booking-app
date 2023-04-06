class CheckoutController < ApplicationController
  before_action :authenticate_user
  before_action :prevent_admin
  before_action :require_booking

  def index
    if session[:booking_id]
      @booking = Booking.find(session[:booking_id])
    else
      @booking = Booking.find(params[:booking_id])
    end
    @order = @booking.order
    @service_orders = @order.service_orders
  end
end
