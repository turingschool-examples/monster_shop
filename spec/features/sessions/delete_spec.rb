
require 'rails_helper'

RSpec.describe "User Login" do
  describe "As a User, When I visit the logout path" do
    before :each do
      @new_user = User.create(user_name: "user_1", password:"123", password_confirmation: "123", name: "John Smith", address: "123 Main St", city: "Boulder", state: "Colorado", zip: 80501)
      visit root_path
      click_link "Login"
      fill_in "User name", with: "user_1"
      fill_in "Password", with: "123"
      click_button "Log In"
    end

    describe  "When I click the logut link" do
      it "I am taken to the welcome page" do
      click_link "Logout"
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Welcome")
      expect(page).to have_content("You have been logged out")
    end
  end
  end
end


