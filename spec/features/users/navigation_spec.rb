require 'rails_helper'

RSpec.describe 'User Navigation' do
  describe 'As a User' do
    before :each do
      @user = User.create(name: "User", address: "123 Clarkson St", city: "Denver", state: "CO", zip: 80209, email: "user@gmail.com", password: "cheetos", role: 0)
      @employee = User.create(name: "Merchant", address: "456 Market St", city: "Denver", state: "CO", zip: 80210, email: "employee@gmail.com", password: "taco_sauce", role: 1)
      @merchant = User.create(name: "Merchant", address: "456 Market St", city: "Denver", state: "CO", zip: 80210, email: "merchant@gmail.com", password: "taco_sauce", role: 2)
      @admin = User.create(name: "Admin", address: "789 Admin Dr", city: "Denver", state: "CO", zip: 80211, email: "admin@gmail.com", password: "rabbit_hole", role: 3)
      visit login_path
    end

    it 'I can not see a link to log in or register when I am logged in' do
      within 'nav' do
        click_on 'Login'
      end

      expect(current_path).to eq(login_path)

      within '#login' do
        fill_in "Email", with: @user.email
        fill_in "Password", with: @user.password
        click_on 'Login'
      end

      expect(current_path).to eq(profile_path)

      within 'nav' do
        expect(page).to_not have_link('Register')
        expect(page).to_not have_link('Login')
      end
    end

    it 'I can see a link to login or register when I am not logged in' do
      within 'nav' do
        expect(page).to have_link('Register')
        expect(page).to have_link('Login')
        expect(page).to_not have_link('Logout')
      end
    end

    it 'I can see a welcome message in navbar' do
      within 'nav' do
        click_on 'Login'
      end

      expect(current_path).to eq(login_path)

      within '#login' do
        fill_in "Email", with: @user.email
        fill_in "Password", with: @user.password
        click_on 'Login'
      end

      within 'nav' do
        expect(page).to have_content("Welcome, #{@user.name}")
      end
    end

    it "I see the same links as a visitor plus merchant dashboard and logout" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

      visit root_path

      within 'nav' do
        expect(page).to have_content("Dashboard")
        expect(page).to have_content("Logout")

        expect(page).to_not have_content("Login")
        expect(page).to_not have_content("Register")
      end
    end
  end
end
