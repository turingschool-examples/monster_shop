require 'rails_helper'

RSpec.describe "Merchant (Merchant_admin role: 1) Can Delete Unordered Items" do
  describe "As a merchant" do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @mermaid = @megan.items.create!(name: 'Mermaid', description: "I'm a Mermaid!", price: 500, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 13 )
      @dragon = @megan.items.create!(name: 'Dragon', description: "I'm a Dragon", price: 2000, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @fairy = @megan.items.create!(name: 'Fairy', description: "I'm a Fairy", price: 25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 60)

      @user_1 = User.create!(name: "Lucifer", user_name: "iheartmonsters", password: "Monsters!", role: 0, address: "666 Hells Gate", city: "Hell", state: "LA", zip: "71220")

      @order_1 = @user_1.orders.create!

      @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 3)
      @order_1.order_items.create!(item: @giant, price: @giant.price, quantity: 1)
      @order_1.order_items.create!(item: @mermaid, price: @mermaid.price, quantity: 16)

      @merchant_admin = User.create!(user_name: "nathan@gmail.com", password: "password123", role: 1, name: "Nathan", address: "123 Market St", city: "Denver", state: "CO", zip: 80012, merchant_id: @megan.id )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_admin)
    end


    it "when i visit my items page I see a link to delete items that have never been ordered" do
      visit "/merchants/#{@megan.id}/items"

      within "#item-#{@dragon.id}" do
        expect(page).to have_link(@dragon.name)
        expect(page).to have_content(@dragon.description)
        expect(page).to have_content("Price: #{number_to_currency(@dragon.price)}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@dragon.inventory}")
        expect(page).to have_content("Sold by: #{@megan.name}")
        expect(page).to have_css("img[src*='#{@dragon.image}']")
        expect(page).to have_link(@megan.name)
        expect(page).to have_link("Delete Item")
      end

      within "#item-#{@fairy.id}" do
        expect(page).to have_link(@fairy.name)
        expect(page).to have_content(@fairy.description)
        expect(page).to have_content("Price: #{number_to_currency(@fairy.price)}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@fairy.inventory}")
        expect(page).to have_content("Sold by: #{@megan.name}")
        expect(page).to have_css("img[src*='#{@fairy.image}']")
        expect(page).to have_link(@megan.name)
        expect(page).to have_link("Delete Item")
      end

      within "#item-#{@ogre.id}" do
        expect(page).to have_no_link("Delete Item")
      end
    end

    it "when I click on 'delete' I am returned to my items index page" do
      visit "/merchants/#{@megan.id}/items"

      within "#item-#{@fairy.id}" do
        click_link "Delete Item"
      end
        expect(current_path).to eq("/merchants/#{@megan.id}/items")
    end

    it "I see a flash message saying the item has been deleted and I no longer see this item" do
      visit "/merchants/#{@megan.id}/items"

      within "#item-#{@dragon.id}" do
        click_link "Delete Item"
      end

      expect(page).to_not have_content(@dragon.price)
      expect(page).to have_content("#{@dragon.name} has been deleted.")
    end
  end
end
