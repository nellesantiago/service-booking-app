require "application_system_test_case"

class ServicesTest < ApplicationSystemTestCase
  def setup
    @user = users(:user)
    @admin = users(:admin)
  end

  test "view all services as an admin" do
    login(@admin)

    click_on "Category one"

    assert_text "Name"
  end

  test "view all services as a customer" do
    login(@user)

    click_on "Category one"

    assert_text "Name"
  end

  test "add a service" do
    login(@admin)

    click_on "Category one"
    assert_text "Name"

    find(".fa-plus").click
    assert_text "New Service"

    fill_in "Name", with: "New"
    fill_in "Details", with: "Details"
    fill_in "Price", with: 200
    attach_file "service[image]", file_fixture("coffee.png")
    click_on "Create"

    assert_text "New"
  end

  test "edit a service" do
    login(@admin)

    click_on "Category one"
    assert_text "Name"

    find(".edit-service-icon").click
    assert_text "Edit Service"

    fill_in "Name", with: "Updated Service"
    click_on "Update"

    assert_text "Service updated!"
  end

  test "delete a service" do
    login(@admin)

    click_on "Category one"
    assert_text "Name"

    page.accept_confirm do
      find(".delete-service-icon").click
    end

    assert_text "Service deleted!"
  end

  test "add an add-on" do
    login(@admin)

    click_on "Category one"
    assert_text "Name"

    find(".fa-plus").click
    assert_text "New Service"

    fill_in "Name", with: "New Add On"
    fill_in "Details", with: "Details"
    fill_in "Price", with: 50
    select "add_on", from: "service_service_type"
    attach_file "service[image]", file_fixture("coffee.png")
    click_on "Create"

    assert_text "Add ons"
  end
end
