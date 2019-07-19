require 'rails_helper'

RSpec.describe 'As a User' do
  describe 'when I logout' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @user = User.create(name: "User", address: "123 Clarkson St", city: "Denver", state: "CO", zip: 80209, email: "user@gmail.com", password: "cheetos", role: 0)
      @merchant = User.create(name: "Merchant", address: "456 Market St", city: "Denver", state: "CO", zip: 80210, email: "merchant@gmail.com", password: "taco_sauce", role: 1, merchant_id: @megan.id)
      @admin = User.create(name: "Admin", address: "789 Admin Dr", city: "Denver", state: "CO", zip: 80211, email: "admin@gmail.com", password: "rabbit_hole", role: 3)
    end

    after :each do
      expect(page).to have_content("You have logged out.")
      expect(page).to_not have_link("Logout")
      expect(page).to have_link("Login")
      expect(page).to have_link("Register")
    end

    it "as a user I see a message that I have logged out and my cart is cleared" do
      megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      ogre = megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      giant = megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      visit root_path

      click_on "Login"
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password

      within '#login' do
        click_on "Login"
      end

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
      visit root_path
      click_on "Login"
      fill_in "Email", with: @merchant.email
      fill_in "Password", with: @merchant.password

      within '#login' do
        click_on "Login"
      end

      visit root_path
      click_on 'Logout'
    end

    it "as a admin I see a message that I have logged out" do
      visit root_path
      click_on "Login"
      fill_in "Email", with: @admin.email
      fill_in "Password", with: @admin.password

      within '#login' do
        click_on "Login"
      end

      visit root_path
      click_on 'Logout'
    end
  end
end
