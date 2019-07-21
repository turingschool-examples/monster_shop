require 'rails_helper'

RSpec.describe 'Cancel Order' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @alex = User.create!(name: "Alex Hennel", address: "123 Straw Lane", city: "Straw City", state: "CO", zip: 12345, email: "straw@gmail.com", password: "fish", role: 0)
      @order_1 = @alex.orders.create!
      @order_1.order_items.create(item: @ogre, quantity: 2, price: @ogre.price)
      @order_1.order_items.create(item: @giant, quantity: 1, price: @giant.price)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@alex)
    end

    it 'I can delete an order from its show page' do
      visit dashboard_order_path(@order_1)

      @order_1.order_items.first.update(status: 'fulfilled')
      @order_1.order_items.last.update(status: 'fulfilled')

      expect(@ogre.inventory).to eq(5)
      expect(@giant.inventory).to eq(3)

      click_on "Cancel Order"

      expect(@order_1.order_items.first.status).to eq("unfulfilled")
      expect(@order_1.order_items.last.status).to eq("unfulfilled")
      expect(@order_1.reload.status).to eq("canceled")
      expect(@ogre.reload.inventory).to eq(7)
      expect(@giant.reload.inventory).to eq(4)
      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Order has been canceled.")
    end
  end
end
