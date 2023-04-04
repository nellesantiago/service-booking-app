class SuccessController < ApplicationController
  before_action :authenticate_user
  
  def index
    unless params[:booking_id] && @booking = Booking.find(params[:booking_id])
      redirect_to categories_path
    end
  end
end
