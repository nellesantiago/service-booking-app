# Preview all emails at http://localhost:3000/rails/mailers/booking_mailer
class BookingMailerPreview < ActionMailer::Preview
    def email_notification
        BookingMailer.with(user: User.last, order: User.last.orders.first, booking: User.last.orders.first.booking).email_notification
    end
end
