require 'rails_helper'

RSpec.describe "Visitor Navigation" do
  describe "As a visitor" do
    it "My navigation bar includes the following:" do

      visit root_path

      expect(page).to have_link("Welcome")
      expect(page).to have_link("Items")
      expect(page).to have_link("Merchants")
      expect(page).to have_link("Cart")
      expect(page).to have_link("Login")
      expect(page).to have_link("Register")
    end

    it "Next to the cart link I see a count of items in my cart" do
      cart = Cart.new(nil)

      visit root_path

      within 'nav' do
        expect(page).to have_content(cart.count)
      end
    end

    it 'does not allow default user to see merchant dashboard' do

      visit merchant_dashboard_path

      expect(page).to_not have_content("Merchant Dashboard")
      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end

    it 'does not allow default user to see admin dashboard' do

      visit admin_dashboard_path

      expect(page).to_not have_content("Admin Dashboard")
      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end

    it 'does not allow default user to see user profile' do

      visit profile_path
      expect(page).to_not have_content("Profile")
      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end
  end
end
