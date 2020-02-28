require 'rails_helper'

RSpec.describe "User Login" do
  describe "As a Visitor" do
    before :each do
    @will = User.create!(user_name: "wthompson", password: "123",  password_confirmation: "123", name: "Will Thompson", address: "123 Main St", city: "Longmont", state: "Colorado", zip: 80501)
    visit root_path
    end

  it "When I click the link to login I am taken to a login form" do
    click_link "Login"
    fill_in "User name", with: "wthompson"
    fill_in "Password", with: "123"
    click_button "Log In"

    expect(current_path).to eq(profile_path)
    end

    it "When I fill in with wrong credentials, i am redirected to login page and I get a flash message telling me that username/password invalid." do
      click_link "Login"
      fill_in "User name", with: "wthompson"
      fill_in "Password", with: "1"
      click_button "Log In"
      expect(page).to have_content "User name and/or password invalid."
    end
  end
end
