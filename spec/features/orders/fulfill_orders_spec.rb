require 'rails_helper'

RSpec.describe "Order Status Packaged" do
  describe "As a merchant" do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @nathan = User.create!(user_name: "nthomas", password: "123",  password_confirmation: "123", name: "Nathan Thomas", address: "123 Main St", city: "Gunbarrel", state: "Colorado", zip: 80301)
      @order_1 = @nathan.orders.create!
      @order_item_1 = @order_1.order_items.create!(price: @ogre.price, quantity: 1, item: @ogre, fulfilled: false)
      @order_item_2 = @order_1.order_items.create!(price: @giant.price, quantity: 1, item: @giant, fulfilled: false)

      @merchant_admin = User.create!(user_name: "nathan@gmail.com", password: "password123", role: 1, name: "Nathan", address: "123 Market St", city: "Denver", state: "CO", zip: 80012, merchant_id: @megan.id )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_admin)
    end

    it 'when all orders have been fullfilled by thier merchants the order status changes from pending to packaged'do
      visit merchant_admins_order_path(@order_1.id)

      within "#item-#{@order_item_1.item.id}" do
        click_button("Fulfill Order")

        expect(@order_1.reload.status).to eq("packaged")
      end
    end
  end
end
