require 'rails_helper'

RSpec.describe "Merchant Edit Item" do
  describe "As a merchant admin" do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @merchant_admin = User.create!(user_name: "nathan@gmail.com", password: "password123", role: 1, name: "Nathan", address: "123 Market St", city: "Denver", state: "CO", zip: 80012, merchant_id: @megan.id )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_admin)
    end
      describe "When I try to edit an existing item. If any of my data is incorrect or missing (except image)" do
        it "Returns to the form and I see one or more flash messages indicating each error I caused.All fields are re-populated with my previous data" do

        visit root_path

      expect(page).to have_link("Welcome")
      expect(page).to have_link("Items")
      expect(page).to have_link("Merchants")
      expect(page).to have_link("Cart")
      expect(page).to have_link("Profile")
      expect(page).to have_link("Merchant Dashboard")
      expect(page).to have_button("Logout")
      expect(page).not_to have_link("Login")
      expect(page).not_to have_link("Register")
    end

    it 'does not allow merchant_admin to see admin dashboard' do

      visit admin_dashboard_path

      expect(page).to_not have_content("Admin Dashboard")
      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end
  end
end
end
