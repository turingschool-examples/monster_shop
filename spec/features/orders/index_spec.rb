require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Create Order' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @alex = User.create!(name: "Alex Hennel", address: "123 Straw Lane", city: "Straw City", state: "CO", zip: 12345, email: "straw@gmail.com", password: "fish", role: 0)
      @order_1 = @alex.orders.create!
      @order_1.order_items.create(item: @ogre, quantity: 2, price: @ogre.price)
      @order_1.order_items.create(item: @hippo, quantity: 1, price: @hippo.price)
      @order_2 = @alex.orders.create!
      @order_2.order_items.create(item: @hippo, quantity: 1, price: @hippo.price)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@alex)
    end

    it 'I can create an order from the new order page' do
      visit profile_orders_path

      within "#order-#{@order_1.id}" do
        expect(page).to have_content("Total: #{number_to_currency((@ogre.price * 2) + (@hippo.price * 1))}")
        expect(page).to have_content("Number of Items: 3")
        expect(page).to have_content("Status: #{@order_1.status}")
        expect(page).to have_content("Date Ordered: #{@order_1.created_at}")
        expect(page).to have_content("Last Updated: #{@order_1.updated_at}")
      end

      within "#order-#{@order_2.id}" do
        expect(page).to have_content("Total: #{number_to_currency(@hippo.price * 1)}")
        expect(page).to have_content("Number of Items: #{@order_2.order_items.length}")
        expect(page).to have_content("Status: #{@order_2.status}")
        expect(page).to have_content("Date Ordered: #{@order_2.created_at}")
        expect(page).to have_content("Last Updated: #{@order_2.updated_at}")
      end
    end
  end
end
