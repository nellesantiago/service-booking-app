class BookingMailer < ApplicationMailer
    default from: 'glowup.chatgenie@gmail.com'

  def email_notification
    @user = params[:user]
    @order = params[:order]
    @booking = params[:booking]
    mail(to: @user.email, subject: 'Booking Confirmation')
  end
end
