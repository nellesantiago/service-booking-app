class BookingsController < ApplicationController
  before_action :authenticate_user
  before_action :prevent_admin, except: :update
  before_action :require_cart_items, except: :update
  
  def new
    if session[:booking_id]
      @booking = Booking.find(session[:booking_id])
    else
      @booking = Booking.new
    end
  end

  def create
    @booking = current_user.bookings.build(booking_params.except(:payment_status))
    if @booking.save
      session[:booking_id] = @booking.id
      redirect_to checkout_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if session[:booking_id]
      @booking = current_user.bookings.find(session[:booking_id])
    else
      @booking = Booking.find(params[:id])
    end

    if @booking.update(booking_params.except(:payment_status))
      if booking_params[:payment_status]
        @booking.payment.update(payment_status: booking_params[:payment_status])
      end
      redirect_to checkout_path if current_user.customer? && request.referrer == new_booking_url
      redirect_to request.referrer
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:first_name, :last_name, :mobile_number, :street, :barangay, :city, :province, :postal_code, :order_id, :status, :payment_status)
  end
end
