class ApplicationController < ActionController::Base
  include SessionsHelper
  include CartHelper
  before_action :initialize_cart

  def initialize_cart
    if user_logged_in?
      @cart ||= current_user.cart

      unless @cart
        @cart = current_user.create_cart
        session[:cart_id] = @cart.id
      end
    end
  end
end
