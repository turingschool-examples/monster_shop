require 'rails_helper'

RSpec.describe 'New User Creation' do
  describe 'As a Visitor' do
    it 'I can link to register from the nav bar' do
      click_on 'Register'

      expect(current_path).to eq('/users/new')
    end

    it 'I can use the new user form to create a new user' do
      visit register_path

      name = 'Megan'
      address = '123 Main St'
      city = "Denver"
      state = "CO"
      zip = 80218
      email = 'megan@turing.io'
      password = 'unicorns'

      fill_in 'Name', with: name
      fill_in 'Address', with: address
      fill_in 'City', with: city
      fill_in 'State', with: state
      fill_in 'Zip', with: zip
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password_conf', with: password

      click_button 'Register'

      expect(current_path).to eq(profile_path)
      expect(page).to have_content('You are now registered and logged in.')
      expect(page).to_not have_content('Register')
      expect(page).to have_content('Log Out')
      expect(User.last.name).to eq(name)
    end

    it 'I can not create a user with an incomplete form' do
      visit register_path

      name = 'Megan'

      fill_in 'Name', with: name

      click_button 'Create Merchant'

      expect(page).to have_content("address: [\"can't be blank\"]")
      expect(page).to have_content("city: [\"can't be blank\"]")
      expect(page).to have_content("state: [\"can't be blank\"]")
      expect(page).to have_content("zip: [\"can't be blank\"]")
      expect(page).to have_button('Create Merchant')
    end
  end
end
