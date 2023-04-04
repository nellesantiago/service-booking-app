require "test_helper"

class BookingTest < ActiveSupport::TestCase
  def setup
    @user = users(:user)
    @order = orders(:one)
    @booking = Booking.new(first_name: "Rails", last_name: "Test", mobile_number: "09091234567", street: "Street", barangay: "Barangay", city: "City", province: "Province", postal_code: "1234", status: "upcoming", user_id: @user.id, order_id: @order.id)
  end

  test "booking should have a user" do
    @booking.user_id = nil
    assert_not @booking.save
  end

  test "booking should have an order" do
    @booking.order_id = nil
    assert_not @booking.save
  end

  test "booking should have a first name" do
    @booking.first_name = nil
    assert_not @booking.save
  end

  test "booking should have a last name" do
    @booking.last_name = nil
    assert_not @booking.save
  end

  test "booking should have a mobile number" do
    @booking.mobile_number = nil
    assert_not @booking.save
  end

  test "booking should have a street" do
    @booking.street = nil
    assert_not @booking.save
  end

  test "booking should have a barangay" do
    @booking.barangay = nil
    assert_not @booking.save
  end

  test "booking should have a city" do
    @booking.city = nil
    assert_not @booking.save
  end

  test "booking should have a province" do
    @booking.province = nil
    assert_not @booking.save
  end

  test "booking should have a postal code" do
    @booking.postal_code = nil
    assert_not @booking.save
  end

  test "mobile number should have a right format" do
    @booking.mobile_number = "2334637475"
    assert_not @booking.save

    @booking.mobile_number = "09091234567"
    assert @booking.save
  end
end
