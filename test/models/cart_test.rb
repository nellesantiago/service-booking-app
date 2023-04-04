require "test_helper"

class CartTest < ActiveSupport::TestCase
  def setup
    @user = users(:user)
    @cart = Cart.new(user_id: @user.id)
  end

  test "cart should have a user" do
    @cart.user_id = nil
    assert_not @cart.save
  end
end
