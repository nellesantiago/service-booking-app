class PaymentsController < ApplicationController
  before_action :authenticate_user
  before_action :require_cart_items

  def cash
    @booking = current_user.bookings.find(session[:booking_id])
    current_user.payments.create(booking: @booking, amount: params[:amount], payment_type: params[:payment_type])
    @booking.update(status: "upcoming")
    session.delete(:booking_id)
    session.delete(:order_id)
    redirect_to success_url(booking_id: @booking.id)
  end

  def card
  end

  def pay
    @payment = Paymongo::V1::Payment.new
    response = @payment.proceed(payment_info_params)
    if response == "succeeded"
      @booking = current_user.bookings.find(session[:booking_id])
      current_user.payments.create(booking: @booking, amount: payment_info_params[:price], payment_type: "card", payment_status: "paid")
      @booking.update(status: "upcoming")
      session.delete(:booking_id)
      session.delete(:order_id)
      redirect_to success_url(booking_id: @booking.id), notice: "Payment successful!"
    elsif response.has_key?("errors") && fraud?(response["errors"].first["detail"])
      redirect_to request.referer, alert: "Something went wrong, please try again later"
    else
      redirect_to request.referer, alert: "#{response["errors"].first["detail"].split("details.").last.gsub("_", " ").capitalize}"
    end
  end

  private

  def payment_info_params
    params.require(:payment_info).permit(:name, :card_number, :exp_month, :exp_year, :cvc, :price, :email)
  end

  def fraud?(str)
    code = ["fraudulent", "processor_blocked", "lost_card", "stolen_card", "blocked"]
    code.each do |e|
      return true if str.downcase.include? e
    end
    return false
  end
end
