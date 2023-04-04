class CartController < ApplicationController
  def add
    @item = @cart.cart_items.find_or_initialize_by(service_id: params[:service_id])
    @quantity = @item.quantity.to_i + params[:quantity].to_i
    return if @quantity < 0
    if @quantity == 0
      @item.destroy
      redirect_to request.referrer
    else
      @item.update(quantity: @quantity)
      redirect_to request.referrer
    end
  end

  def remove
  end
end
