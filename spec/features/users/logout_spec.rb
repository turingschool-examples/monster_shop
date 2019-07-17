require 'rails_helper'

RSpec.describe 'As a User' do
  describe 'when I logout' do
    before :each do
      @user = User.create(name: "User", address: "123 Clarkson St", city: "Denver", state: "CO", zip: 80209, email: "user@gmail.com", password: "cheetos", role: 0)
      @merchant = User.create(name: "Merchant", address: "456 Market St", city: "Denver", state: "CO", zip: 80210, email: "merchant@gmail.com", password: "taco_sauce", role: 1)
      @admin = User.create(name: "Admin", address: "789 Admin Dr", city: "Denver", state: "CO", zip: 80211, email: "admin@gmail.com", password: "rabbit_hole", role: 2)
    end

    after :each do
      expect(page).to have_content("You have logged out.")
    end

    it "as a user I see a message that I have logged out and my cart is cleared" do
      megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      ogre = megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      giant = megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit item_path(ogre)

      click_button 'Add to Cart'
      within 'nav' do
        expect(page).to have_content("Cart: 1")
      end
      visit root_path
      click_on 'Logout'
      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end
    end

    it "as a merchant I see a message that I have logged out" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

      visit root_path
      click_on 'Logout'
    end

    it "as a admin I see a message that I have logged out" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit root_path
      click_on 'Logout'
    end

  end
end
