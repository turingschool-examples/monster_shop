require 'rails_helper'

RSpec.describe 'New User Creation' do
  describe 'As a Visitor' do
    before :each do
      visit root_path
      click_link 'Register'

      expect(current_path).to eq(register_path)
    end

    it 'I can use the new user form to create a new user' do
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
      fill_in :confirm_password, with: password

      click_button 'Register'

      expect(page).to have_content('You are now registered and logged in.')
      expect(current_path).to eq(profile_path)
      expect(User.last.name).to eq(name)
      expect(page).to_not have_button('Register')
      expect(page).to have_content('Logout')
    end

    it 'I can not create a user with an incomplete form' do
      click_button 'Register'

      expect(page).to have_content("name: [\"can't be blank\"]")
      expect(page).to have_content("address: [\"can't be blank\"]")
      expect(page).to have_content("city: [\"can't be blank\"]")
      expect(page).to have_content("state: [\"can't be blank\",")
      expect(page).to have_content("zip: [\"can't be blank\",")
      expect(page).to have_content("email: [\"can't be blank\"]")
      expect(page).to have_content("password: [\"can't be blank\"]")
      expect(page).to have_button('Register')
    end

    it 'I can not create a user with a reused email' do
      megan = User.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@turing.io', password: 'unicorns')
      impostor_megan = User.create(name: 'Megan2', address: '1234 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@turing.io', password: 'vampires')

      expect(User.last.name).to eq('Megan')

      name = 'Megan2'
      address = '1234 Main St'
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
      fill_in :confirm_password, with: password

      click_button 'Register'

      expect(page).to have_content("email: [\"has already been taken\"]")
    end

    it 'I can not create a user when confirm password doesnt match' do
      name = 'Tyler'
      address = '1234 Main St'
      city = "Denver"
      state = "CO"
      zip = 80218
      email = 'tyler@gmail.com'
      password = 'noodles'

      fill_in 'Name', with: name
      fill_in 'Address', with: address
      fill_in 'City', with: city
      fill_in 'State', with: state
      fill_in 'Zip', with: zip
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in :confirm_password, with: "noodle"

      click_button 'Register'

      expect(page).to have_content("Password does not match!")
    end
  end
end
