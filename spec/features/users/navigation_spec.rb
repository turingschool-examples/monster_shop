require 'rails_helper'

RSpec.describe 'User Navigation' do
  describe 'As a User' do

    it 'I can not see a link to log in or register when I am logged in' do
      user = User.create(name: "Test Test", address: "123", city: "Denver", state: "CO", zip: 80209, email: "test@gmail.com", password: "password", role: 0)
      visit root_path

      within 'nav' do
        click_on 'Login'
      end

      expect(current_path).to eq(login_path)

      within '#login' do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_on 'Login'
      end

      expect(current_path).to eq(root_path)

      within 'nav' do
        expect(page).to_not have_link('Register')
        expect(page).to_not have_link('Login')
      end

    end
  end
end
