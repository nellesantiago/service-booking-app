class PaymentsController < ApplicationController
  before_action :authenticate_user
  before_action :require_booking, except: :pay

  def cash
    if session[:booking_id]
      @booking = current_user.bookings.find(session[:booking_id])
    else
      @booking = current_user.bookings.find(params[:booking_id])
    end
    current_user.payments.create(booking: @booking, amount: params[:amount], payment_type: params[:payment_type])
    @booking.update(status: "upcoming")
    session.delete(:booking_id)
    session.delete(:order_id)
    BookingMailer.with(user: current_user, order: @booking.order, booking: @booking).email_notification.deliver_now 
    redirect_to success_url(booking_id: @booking.id)
  end

  def card
    if session[:booking_id]
      @booking = current_user.bookings.find(session[:booking_id])
    else
      @booking = current_user.bookings.find(params[:booking_id])
    end
  end

  def pay
    @payment = Paymongo::V1::Payment.new
    response = @payment.proceed(payment_info_params.except(:booking_id))
    if response == "succeeded"
      if session[:booking_id]
        @booking = current_user.bookings.find(session[:booking_id])
      else
        @booking = current_user.bookings.find(payment_info_params[:booking_id])
      end
      current_user.payments.create(booking: @booking, amount: payment_info_params[:price], payment_type: "card", payment_status: "paid")
      @booking.update(status: "upcoming")
      session.delete(:booking_id)
      session.delete(:order_id)
      BookingMailer.with(user: current_user, order: @booking.order, booking: @booking).email_notification.deliver_now 
      redirect_to success_url(booking_id: @booking.id), notice: "Payment successful!"
    elsif response.has_key?("errors") && fraud?(response["errors"].first["detail"])
      redirect_to request.referer, alert: "Something went wrong, please try again later"
    else
      redirect_to request.referer, alert: "#{response["errors"].first["detail"].split("details.").last.gsub("_", " ").capitalize}"
    end
  end

  private

  def payment_info_params
    params.require(:payment_info).permit(:name, :card_number, :exp_month, :exp_year, :cvc, :price, :email, :booking_id)
  end

  def fraud?(str)
    code = ["fraudulent", "processor_blocked", "lost_card", "stolen_card", "blocked"]
    code.each do |e|
      return true if str.downcase.include? e
    end
    return false
  end
end
