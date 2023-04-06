require "application_system_test_case"

class CategoriesTest < ApplicationSystemTestCase
  def setup
    @admin = users(:admin)
    login(@admin)
  end

  test "view all categories" do
    assert_text "+"
  end

  test "add a category" do
    click_on "+"

    assert_text "< New Category"

    fill_in "Name", with: "New"
    fill_in "Description", with: "Description"
    attach_file "category[image]", file_fixture("coffee.png")

    click_on "Create"

    assert_text "New"
  end

  test "edit a category" do
    click_on "Category one"
    page.accept_confirm do
      find(".fa-trash-can", match: :first).click
    end

    assert_text "Category deleted!"
  end

  test "delete a category" do
    click_on "Category one"
    find(".fa-pen-to-square", match: :first).click
  end
end
