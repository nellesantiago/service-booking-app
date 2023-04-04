require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  def setup
    @user = users(:user)
    @admin = users(:admin)
    visit root_path
  end 

  test "log in with valid credentials" do
    login(@user)
    click_on "Profile"
    assert_text @user.email
  end

  test "log out as a customer" do
    login(@user)

    click_on "Profile"
    click_on "Log out"
    assert_text "Glow up"
  end

  test "create a new account" do
    click_on "Sign up!"

    assert_text "Already have an account? Log in"

    fill_in "Email", with: "rails@test.com"
    fill_in "Password", with: "123456"
    fill_in "Confirm Password", with: "123456"

    click_on "Create User"

    assert_text "Welcome!"
  end

  test "edit account details" do
    login(@user)

    click_on "Profile"
    click_on "Settings"
    assert_text "Settings"
    
    fill_in "Email", with: "new@email.com"
    click_on "Update User"

    assert_text "Account updated!"
  end

  test "delete account" do
    login(@user)

    click_on "Profile"
    click_on "Settings"
    
    page.accept_confirm do
      click_on "Delete Account"
    end

    assert_text "Account deleted!"
  end

  test "log in as admin" do
    login(@admin)

    assert_text "Users"
  end

  test "log out as an admin" do
    login(@admin)

    click_on "Log out"
    assert_text "Glow up"
  end

  test "view all users" do
    login(@admin)

    click_on "Users"
    assert_text "Users"
  end

  test "delete a user as an admin" do
    login(@admin)

    click_on "Users"

    page.accept_confirm do
      find(".fa-trash-can").click
    end

    assert_text "User deleted!"
  end
end