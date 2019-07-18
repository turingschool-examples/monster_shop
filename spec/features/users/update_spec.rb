require 'rails_helper'

RSpec.describe 'Visitor' do
  describe 'I see a form like the registration page' do
    before :each do
      @alex = User.create!(name: "Alex Hennel", address: "123 Straw Lane", city: "Straw City", state: "CO", zip: 12345, email: "straw@gmail.com", password: "fish")
      @alex2 = User.create!(name: "Alex Hennel", address: "123 Straw Lane", city: "Straw City", state: "CO", zip: 12345, email: "blah@gmail.com", password: "fish")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@alex2)
    end

    it 'The form is prepopulated with current info except password' do

      visit profile_path
      click_link "Edit Profile"

      fill_in "Name", with: "Alex Hennel"
      fill_in "Address", with: "123 Straw Lane"
      fill_in "City", with: "Straw City"
      fill_in "State", with: "CO"
      fill_in "Zip", with: 12345
      fill_in "Email", with: "blah@gmail.com"
      click_button "Update Profile"

      expect(current_path).to eq(profile_path)
      expect(page).to have_content(@alex2.name)
      expect(page).to have_content(@alex2.address)
      expect(page).to have_content(@alex2.city)
      expect(page).to have_content(@alex2.state)
      expect(page).to have_content(@alex2.zip)
      expect(page).to have_content(@alex2.email)
    end

    it 'I cannot change my email to one that already exists' do
      visit profile_path
      click_link "Edit Profile"

      fill_in "Name", with: "Alex Hennel"
      fill_in "Address", with: "123 Straw Lane"
      fill_in "City", with: "Straw City"
      fill_in "State", with: "CO"
      fill_in "Zip", with: 12345
      fill_in "Email", with: "straw@gmail.com"
      click_button "Update Profile"

      expect(page).to have_content("email: [\"has already been taken\"]")

      visit profile_path
      click_link "Edit Profile"

      fill_in "Name", with: "Alex Hennel"
      fill_in "Address", with: "123 Straw Lane"
      fill_in "City", with: "Straw City"
      fill_in "State", with: "CO"
      fill_in "Zip", with: 12345
      fill_in "Email", with: "frogs@gmail.com"
      click_button "Update Profile"

      expect(page).to have_content('Your profile has been updated!')
    end

    it 'I can edit my password and see a flash message that I have done so' do
      visit profile_path
      click_link 'Change Password'

      fill_in 'Current Password', with: "fish"
      fill_in "Password", with: "newpassword"
      fill_in "Confirm Password", with: "newpassword"

      click_button 'Change Password'
      expect(page).to have_content("Your password has been updated")
      expect(@alex2.authenticate('newpassword')).to eq(@alex2)
      expect(current_path).to eq(profile_path)
      within 'nav' do
        click_link 'Logout'
      end
      
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Welcome to MonsterShop")

      click_link 'Login'

      fill_in "Email", with: "blah@gmail.com"
      fill_in "Password", with: "newpassword"

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("You have logged in.")
    end
  end
end
