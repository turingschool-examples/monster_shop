require 'rails_helper'

RSpec.describe "Merchant (Merchant_admin role: 1) Can Activate an inactive item" do
  describe "As a merchant" do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: false, inventory: 3 )

      @user_1 = User.create!(name: "Lucifer", user_name: "iheartmonsters", password: "Monsters!", role: 0, address: "666 Hells Gate", city: "Hell", state: "LA", zip: "71220")

      @order_1 = @user_1.orders.create!

      @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 3)

      @merchant_admin = User.create!(user_name: "nathan@gmail.com", password: "password123", role: 1, name: "Nathan", address: "123 Market St", city: "Denver", state: "CO", zip: 80012, merchant_id: @megan.id )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_admin)
    end


    it "when i visit my items page I see a link to activate items that are inactive" do
      visit "/merchants/#{@megan.id}/items"

      within "#item-#{@ogre.id}" do
        expect(page).to have_link(@ogre.name)
        expect(page).to have_content("Active")
        expect(page). to have_no_link("Activate Item")
      end
      within "#item-#{@giant.id}" do
        expect(page).to have_link(@giant.name)
        expect(page).to have_content("Inactive")
        expect(page).to have_link("Activate Item")
      end
    end

    it "When I click on 'Activate' I am returned to the items page where I see a flash message indicating the item is now for sale and I see the item is now active" do

      visit "/merchants/#{@megan.id}/items"
      within "#item-#{@giant.id}" do
        expect(page).to have_content("Inactive")
        expect(page).to have_link("Activate Item")
        click_link("Activate")
			end
        expect(page).to have_content("Active")
      expect(page).to have_content("#{@giant.name} is now for sale.")
    end
  end
end
