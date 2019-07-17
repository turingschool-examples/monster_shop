require 'rails_helper'

describe 'User visits profile or dashboard page' do
  context 'as admin' do
    it 'can only see admin dashboard' do
      admin = User.create!(name: "Larry Green", address: "345 Blue Lane", city: "Blue City", state: "CA", zip: 56789, email: "green@gmail.com", password: "bear", role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_dashboard_path

      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content("Admin Dashboard")

      visit merchant_dashboard_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)

      visit profile_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)

      visit cart_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end
  end

  context 'as a merchant user' do
    it 'can only see merchant dashboard' do
      merchant = User.create!(name: "Berry Blue", address: "345 Blue Lane", city: "Blue City", state: "CA", zip: 56789, email: "blue@gmail.com", password: "bear", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
      visit admin_dashboard_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)

      visit merchant_dashboard_path

      expect(current_path).to eq(merchant_dashboard_path)
      expect(page).to have_content("Merchant Dashboard")

      visit profile_path

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Profile")

      visit cart_path

      expect(current_path).to eq(cart_path)
      expect(page).to have_content("My Cart")
    end
  end

  context 'as a regular user' do
    it 'can only see profile' do
      user = User.create!(name: "Alex Hennel", address: "123 Straw Lane", city: "Straw City", state: "CO", zip: 12345, email: "straw@gmail.com", password: "fish", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit admin_dashboard_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)

      visit merchant_dashboard_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)

      visit profile_path

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Profile")

      visit cart_path

      expect(current_path).to eq(cart_path)
      expect(page).to have_content("My Cart")
    end
  end
end
