require "test_helper"

class ServiceTest < ActiveSupport::TestCase
  def setup
    @file = fixture_file_upload(Rails.root.join('test/fixtures/files', 'coffee.png'), 'image/png')
    @category = categories(:first)
    @service = @category.services.build(name: "Service", details: "Texts", price: 200, image: @file)
  end

  test "service should have valid attributes" do
    assert @service.save
  end

  test "service should have a name" do
    @service.name = nil
    assert_not @service.save
  end

  test "service should have a details" do
    @service.details = nil
    assert_not @service.save
  end

  test "service should have a price" do
    @service.price = nil
    assert_not @service.save
  end

  test "name should not exceed maximum of 20 characters" do
    @service.name = "abcdefghijklmnopqrstuvwxyz"
    assert_not @service.save
  end

  test "price should be greater than 0" do
    @service.price = 0
    assert_not @service.save
    
    @service.price = -1
    assert_not @service.save

    @service.price = 100
    assert @service.save
  end
end
