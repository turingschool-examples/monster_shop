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

RSpec.describe 'As a registered user' do
  describe 'when I visit my  profile page' do
    before do
      @user = User.create!(email: 'gijoe@icloud.com', password: 'combat', role: 0, name: 'Joe Camo', address: '543 Bootcamp Way', city: 'Fort Bragg', state: 'NC', zip: 28303)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'loads a page' do
      visit profile_path

      expect(current_path).to eq(profile_path)
    end

    describe 'shows any orders placed' do
      it "has link 'My Orders'" do
        visit profile_path

        expect(page).to have_link('My Orders')
      end

      it "When I click 'My Orders' link, I am taken to /profile/orders/" do
        visit profile_path

        click_link('My Orders')

        expect(current_path).to eq(profile_orders_path)
      end
    end
  end
end

RSpec.describe 'As an unregistered user' do
  it 'shows a 404 page if invalid user_id is entered' do
    visit profile_path

    expect(current_path).to eq(profile_path)
    expect(page.status_code).to eq(404)
    expect(page).to_not have_content('Name: ')
    expect(page).to_not have_content('E-Mail: ')
    expect(page).to_not have_content('Address: ')
    expect(page).to_not have_content('City: ')
    expect(page).to_not have_content('State: ')
    expect(page).to_not have_content('Zip: ')
    expect(page).to have_content("The page you were looking for doesn't exist")
  end
end
