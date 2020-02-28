require 'rails_helper'

RSpec.describe "New User Form" do
  describe "As a visitor, when I click the Register link in the nav bar"
  it "takes me to a form where I can create a new user." do
    visit root_path

    click_link "Register"

    expect(current_path).to eq(new_user_path)

    fill_in "User name", with: "jsmith123"
    fill_in "Name", with: "John Smith"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"
    fill_in "Address", with: "123 Main St"
    fill_in "City", with: "Denver"
    fill_in "State", with: "Colorado"
    fill_in "Zip", with: 80501

    click_button "Create User"

    new_user = User.last
    expect(page).to have_content("You have been registered and logged in!")
    expect(page).to have_content("John Smith")
    expect(page).to have_content("123 Main St")
    expect(page).to have_content("Denver")
    expect(page).to have_content("Colorado")
    expect(current_path).to eq(profile_path)

  end

  describe "If I do not fill in the form completely" do
    it "re-renders the user creation  form with a flash message for missing fields" do
      visit new_user_path
      fill_in "Name", with: "John Smith"
      fill_in "Password", with: "password123"
      fill_in "Password confirmation", with: "password123"
      fill_in "Address", with: "123 Main St"
      fill_in "City", with: "Denver"
      fill_in "State", with: "Colorado"
      fill_in "Zip", with: 80501

      click_button "Create User"

      expect(current_path).to eq(users_path)
      expect(page).to have_content("User name can't be blank")
    end
  end

  describe "If I fill in the full form, but include an email address that is already in the system" do
    it "redirects to the form with a flash message saying the username is already taken" do

      visit new_user_path

      fill_in "Name", with: "John Smith"
      fill_in "User name", with: "jsmith123"
      fill_in "Password", with: "password123"
      fill_in "Password confirmation", with: "password123"
      fill_in "Address", with: "123 Main St"
      fill_in "City", with: "Denver"
      fill_in "State", with: "Colorado"
      fill_in "Zip", with: 80501

      click_button "Create User"


      visit new_user_path

      fill_in "Name", with: "John Smith"
      fill_in "User name", with: "jsmith123"
      fill_in "Password", with: "password123"
      fill_in "Password confirmation", with: "password123"
      fill_in "Address", with: "123 Main St"
      fill_in "City", with: "Denver"
      fill_in "State", with: "Colorado"
      fill_in "Zip", with: 80501

      click_button "Create User"

      expect(page).to have_content("User name has already been taken")
    end
  end
end
