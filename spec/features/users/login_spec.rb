require 'rails_helper'

RSpec.describe 'As a Vistor' do
  describe 'when I login' do
    before :each do
      @user = User.create(name: "User", address: "123 Clarkson St", city: "Denver", state: "CO", zip: 80209, email: "user@gmail.com", password: "cheetos", role: 0)
      @merchant = User.create(name: "Merchant", address: "456 Market St", city: "Denver", state: "CO", zip: 80210, email: "merchant@gmail.com", password: "taco_sauce", role: 1)
      @admin = User.create(name: "Admin", address: "789 Admin Dr", city: "Denver", state: "CO", zip: 80211, email: "admin@gmail.com", password: "rabbit_hole", role: 2)
    end

    after :each do
      expect(page).to have_content("You have logged in.")
    end

    it "as a regular user I am redirected to my profile page" do
      visit login_path

      within '#login' do
        fill_in "Email", with: @user.email
        fill_in "Password", with: @user.password
        click_on 'Login'
      end

      expect(current_path).to eq(profile_path)
    end

    it "as a merchant I am redirected to my merchant dashboard" do
      visit login_path

      within '#login' do
        fill_in "Email", with: @merchant.email
        fill_in "Password", with: @merchant.password
        click_on 'Login'
      end

      expect(current_path).to eq(merchant_dashboard_path)
    end

    it "as an admin I am redirected to my admin dashboard" do
      visit login_path

      within '#login' do
        fill_in "Email", with: @admin.email
        fill_in "Password", with: @admin.password
        click_on 'Login'
      end

      expect(current_path).to eq(admin_dashboard_path)
    end

  end
end
