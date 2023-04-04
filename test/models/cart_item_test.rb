require "test_helper"

class CartItemTest < ActiveSupport::TestCase
  def setup
    @service = services(:one)
    @cart = carts(:one)
    @cart_item = @cart.cart_items.build(quantity: 2, service_id: @service.id)
  end 

  test "cart item quantity should not be less than 0" do
    @cart_item.quantity = -1
    assert_not @cart_item.save

    @cart_item.quantity = 0
    assert @cart_item.save

    @cart_item.quantity = 1
    assert @cart_item.save
  end

  test "cart item should have a cart" do
    @cart_item.cart_id = nil
    assert_not @cart_item.save
  end

  test "cart item should have a service" do
    @cart_item.service_id = nil
    assert_not @cart_item.save
  end

  test "cart items should get the right total" do
    @total = @service.price * @cart_item.quantity
    assert_equal @total, @cart_item.total
  end
end
