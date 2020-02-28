require 'rails_helper'

RSpec.describe "Merchant admin order show page" do
  before :each do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 75, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    @nathan = User.create!(user_name: "nthomas", password: "123",  password_confirmation: "123", name: "Nathan Thomas", address: "123 Main St", city: "Gunbarrel", state: "Colorado", zip: 80301)
    @merchant_admin = User.create!(user_name: "nathan@gmail.com", password: "password123", role: 1, name: "Nathan", address: "123 Market St", city: "Denver", state: "CO", zip: 80012, merchant_id: @megan.id )
    @order_1 = @nathan.orders.create!
    @order_item_1 = @order_1.order_items.create!(price: @ogre.price, quantity: 3, item: @ogre)
    @order_item_2 = @order_1.order_items.create!(price: @giant.price, quantity: 100, item: @giant)
    @order_item_3 = @order_1.order_items.create!(price: @hippo.price, quantity: 2, item: @hippo)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_admin)
    visit merchant_admins_order_path(@order_1)
  end

  describe "When I visit an order show page from my dashboard" do
    it "I see the customer's name and address" do
      expect(page).to have_content(@nathan.name)
      expect(page).to have_content(@nathan.address)
    end

    it "I only see the items in the order that are being purchased from my merchant and do not see items in the order from other merchants." do
      expect(page).to have_content(@ogre.name)
      expect(page).to have_content(@giant.name)
      expect(page).to_not have_content(@hippo.name)
    end

    it "For each item I see the name of the Item, whis is a link to the item show page and the price" do
      expect(page).to have_link(@ogre.name)
      expect(page).to have_link(@giant.name)
      expect(page).to_not have_link(@hippo.name)
      expect(page).to have_content(@ogre.price)
      expect(page).to have_content(@giant.price)
      expect(page).to_not have_content(@hippo.price)
    end

    it "I do not see a fulfill button or link. Instead I see a notice next to the item indicating I cannot fulfill this item"  do
      within "#item-#{@ogre.id}" do
        expect(page).to have_button("Fulfill Order")
      end

      within "#item-#{@giant.id}" do
        expect(page).to have_content("You do not have a high enough inventory to fulfill the order")
      end
    end

    it "When I click on that link or button I am returned to the order show page, I see the item is now fulfilled. I also see a flash message indicating that I have fulfilled that item. the item's inventory quantity is permanently reduced by the user's desired quantity"  do
      click_button "Fulfill Order"
      expect(page).to have_content("You have already fulfilled this order")
      expect(page).to_not have_button("Fulfill Order")
    end
  end
end
