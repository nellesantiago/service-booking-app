require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @file = fixture_file_upload(Rails.root.join('test/fixtures/files', 'coffee.png'), 'image/png')
    @category = Category.new(name: "Category", description: "Test", image: @file)
  end

  test "category should have valid attributes" do
    assert @category.save
  end

  test "category should have a name" do
    @category.name = nil
    assert_not @category.save
  end

  test "category should have a description" do
    @category.description = nil
    assert_not @category.save
  end

  test "name should not exceed maximum of 20 characters" do
    @category.name = "abcdefghijklmnopqrstuvwxyz"
    assert_not @category.save
  end
end
