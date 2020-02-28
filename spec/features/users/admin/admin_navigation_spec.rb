require 'rails_helper'

RSpec.describe "Admin Navigation" do
  describe "As an admin" do
    before :each do
      @admin = User.create!(user_name: "andrew@gmail.com", password: "thinking123", role: 2, name: "Andrew", address: "333 Market St", city: "Denver", state: "CO", zip: 80012 )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end
    it "My navigation bar includes the following:" do

      visit root_path

      expect(page).to have_link("Welcome")
      expect(page).to have_link("Items")
      expect(page).to have_link("Merchants")
      expect(page).to have_link("Admin Dashboard")
      expect(page).to have_button("Logout")
      expect(page).to have_link("All Users")

      expect(page).not_to have_link("Cart")
      expect(page).not_to have_link("Login")
      expect(page).not_to have_link("Register")
			expect(page).not_to have_link("Profile")
    end

    it 'does not allow admin to see merchant dashboard' do

      visit merchant_dashboard_path

      expect(page).to_not have_content("Merchant Dashboard")
      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end

    it 'does not allow admin to see user profile' do

      visit profile_path
      expect(page).to_not have_content("Profile")
      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end

    it 'does not allow admin to see user the cart' do

      visit cart_path
      expect(page).to_not have_content("Cart")
      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end
  end
end
