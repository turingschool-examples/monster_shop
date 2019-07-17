require 'rails_helper'

RSpec.describe 'Visitor' do
  describe 'I see a form like the registration page' do
    before :each do
      @alex = User.create!(name: "Alex Hennel", address: "123 Straw Lane", city: "Straw City", state: "CO", zip: 12345, email: "straw@gmail.com", password: "fish")
    end

    it 'The form is prepopulated with current info except password' do
      visit "/users/#{@alex.id}"
      click_link "Edit Profile"

      fill_in "Name", with: "Alex Hennel"
      fill_in "Address", with: "123 Straw Lane"
      fill_in "City", with: "Straw City"
      fill_in "State", with: "CO"
      fill_in "Zip", with: 12345
      fill_in "Email", with: "straw@gmail.com"
      click_button "Update Profile"

      expect(current_path).to eq("/users/#{@alex.id}")
      expect(page).to have_content(@alex.name)
      expect(page).to have_content(@alex.address)
      expect(page).to have_content(@alex.city)
      expect(page).to have_content(@alex.state)
      expect(page).to have_content(@alex.zip)
      expect(page).to have_content(@alex.email)
    end
  end
end
