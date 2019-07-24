require 'rails_helper'

RSpec.describe 'As a registered user' do
  describe 'when I visit my own profile page' do
    before do
      @user = User.create!(email: 'gijoe.icloud.com', password: 'combat', role: 0, name: 'Joe', address: '123 Military Circle', city: 'Fort Bragg', state: 'NC', zip: 30210)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit profile_path
    end

    it 'loads a page' do
      expect(page.status_code).to eq(200)
      expect(current_path).to eq(profile_path)
    end

    it 'shows me all data except password' do
      within("#user-#{@user.id}") do
        expect(page).to have_content("Name: #{@user.name}")
        expect(page).to have_content("Email: #{@user.email}")
        expect(page).to have_content("Address: #{@user.address}")
        expect(page).to have_content("City: #{@user.city}")
        expect(page).to have_content("State: #{@user.state}")
        expect(page).to have_content("Zip: #{@user.zip}")
      end
    end

    it 'shows a link to edit profile data' do
      expect(page).to have_link('Edit Profile')
    end

    describe 'when I have orders placed in the system' do
      it "I see a link on my profile page called 'My Orders'" do
        expect(page).to have_link('My Orders')
      end

      it "When I click 'My Orders' link, I am taken to /profile/orders/" do
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
    expect(page).to_not have_content('Email: ')
    expect(page).to_not have_content('Address: ')
    expect(page).to_not have_content('City: ')
    expect(page).to_not have_content('State: ')
    expect(page).to_not have_content('Zip: ')
    expect(page).to have_content("The page you were looking for doesn't exist")
  end
end
