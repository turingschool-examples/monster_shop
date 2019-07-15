require 'rails_helper'

RSpec.describe 'Visitor' do
  describe 'I visit my profile page' do
    before :each do
      @alex = User.create!(name: "Alex Hennel", address: "123 Straw Lane", city: "Straw City", state: "CO", zip: 12345, email: "straw@gmail.com", password: "fish")
    end

    it 'I see my profile data and a link to edit my profile data except password' do
      visit "/users/#{@alex.id}"

      expect(page).to have_content(@alex.name)
      expect(page).to have_content(@alex.address)
      expect(page).to have_content(@alex.city)
      expect(page).to have_content(@alex.state)
      expect(page).to have_content(@alex.zip)
      expect(page).to have_content(@alex.email)
      expect(page).to have_link('Edit Profile')
    end
  end
end
