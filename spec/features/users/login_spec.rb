require 'rails_helper'

RSpec.describe 'As a Vistor' do
  describe 'when I login' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @user = User.create(name: "User", address: "123 Clarkson St", city: "Denver", state: "CO", zip: 80209, email: "user@gmail.com", password: "cheetos", role: 0)
      @employee = User.create(name: "Merchant", address: "456 Market St", city: "Denver", state: "CO", zip: 80210, email: "employee@gmail.com", password: "taco_sauce", role: 1, merchant_id: @megan.id)
      @merchant = User.create(name: "Merchant", address: "456 Market St", city: "Denver", state: "CO", zip: 80210, email: "merchant@gmail.com", password: "taco_sauce", role: 2, merchant_id: @megan.id)
      @admin = User.create(name: "Admin", address: "789 Admin Dr", city: "Denver", state: "CO", zip: 80211, email: "admin@gmail.com", password: "rabbit_hole", role: 3)
      visit login_path
    end

    it "as a regular user I am redirected to my profile page" do
      within '#login' do
        fill_in "Email", with: @user.email
        fill_in "Password", with: @user.password
        click_on 'Login'
      end

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("You have logged in.")

      visit login_path

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("You are already logged in.")
    end

    it "as an employee I am redirected to my merchant dashboard" do
      within '#login' do
        fill_in "Email", with: @merchant.email
        fill_in "Password", with: @merchant.password
        click_on 'Login'
      end

      expect(current_path).to eq(merchant_dashboard_path)
      expect(page).to have_content("You have logged in.")

      visit login_path

      expect(current_path).to eq(merchant_dashboard_path)
      expect(page).to have_content("You are already logged in.")
    end

    it "as a merchant I am redirected to my merchant dashboard" do
      within '#login' do
        fill_in "Email", with: @merchant.email
        fill_in "Password", with: @merchant.password
        click_on 'Login'
      end

      expect(current_path).to eq(merchant_dashboard_path)
      expect(page).to have_content("You have logged in.")

      visit login_path

      expect(current_path).to eq(merchant_dashboard_path)
      expect(page).to have_content("You are already logged in.")
    end

    it "as an admin I am redirected to my admin dashboard" do
      within '#login' do
        fill_in "Email", with: @admin.email
        fill_in "Password", with: @admin.password
        click_on 'Login'
      end

      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content("You have logged in.")

      visit login_path

      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content("You are already logged in.")
    end

    it "I cannot login with bad credentials" do
      within '#login' do
        fill_in "Email", with: 'fish@email.com'
        fill_in "Password", with: 'fish'
        click_on 'Login'
      end

      expect(current_path).to eq(login_path)
      expect(page).to have_content('Username and password do not match.')

      within '#login' do
        fill_in "Email", with: @user.email
        fill_in "Password", with: @user.password
        click_on 'Login'
      end

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("You have logged in.")
    end

    it "I cannot login if my account has been disabled" do
      @user.reload.update(enabled: false)

      within '#login' do
        fill_in "Email", with: @user.email
        fill_in "Password", with: @user.password
        click_on 'Login'
      end
      
      expect(current_path).to eq(login_path)
      expect(page).to have_content('You cannot log in because your account has been disabled.')
    end
  end
end
