require 'rails_helper'

RSpec.describe 'User Navigation' do
  describe 'As a User' do

    it 'I can not see a link to log in or register when I am logged in' do
      user = User.create(name: "Test Test", address: "123", city: "Denver", state: "CO", zip: 80209, email: "test@gmail.com", password: "password", role: 1)
      visit root_path

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      expect(page).to_not have_button('Register')
      expect(page).to_not have_button('Login')
    end
  end
end
