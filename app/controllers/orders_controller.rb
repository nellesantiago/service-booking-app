class OrdersController < ApplicationController
  before_action :authenticate_user
  before_action :prevent_admin, except: %i[index show]
  before_action :require_cart_items, only: %i[new create]

  def index
    if current_user.admin?
      @orders = Order.all
    else
      @orders = current_user.orders.select { |order| order.booking.status == "upcoming" }
    end
  end

  def history
    @orders = current_user.orders.select { |order| order.booking.status == "done" }
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    if session[:order_id]
      @order = Order.find(session[:order_id])
      @order_date = @order.date
    else
      @order = Order.new
      @order_date = Date.current + 1.day
    end
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      @cart.cart_items.each do |item|
        @order.service_orders.create!(quantity: item.quantity, service_id: item.service_id)
      end
      session[:order_id] = @order.id
      redirect_to new_booking_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @order = Order.find(session[:order_id])
    if @order.update(order_params)
      redirect_to new_booking_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def schedules
    @order = Order.new
    @time_slots = TimeSlot.where(category_id: @cart.category).select { |time| time.available(params[:date], @cart) }
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def order_params
    params.require(:order).permit(:date, :time_slot_id)
  end
end
