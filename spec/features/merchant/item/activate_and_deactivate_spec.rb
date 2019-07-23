# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a merchant' do
  describe 'when I visit my items page' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80_218)
      @larry = User.create!(name: 'Larry Green', address: '345 Blue Lane', city: 'Blue City', state: 'CA', zip: 56_789, email: 'green@gmail.com', password: 'frogs', role: 2, merchant_id: @megan.id)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5)
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
      @hippo = @megan.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: false, inventory: 3)
      @meg = User.create!(name: 'Megan M', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80_218, email: 'meg@gmail.com', password: 'fish')
      @order2 = @larry.orders.create!
      @order2.order_items.create!(item: @giant, price: @giant.price, quantity: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@larry)
    end

    it 'shows a message and returns a page if I disable an item' do
      visit dashboard_items_path

      within "#item-#{@ogre.id}" do
        expect(@ogre.active).to eq(true)
        click_button 'Disable Item'
        expect(current_path).to eq(dashboard_items_path)
        expect(@ogre.reload.active).to eq(false)
      end
      expect(page).to have_content("#{@ogre.name} is no longer available for sale.")
    end

    it 'shows a message and returns a page if I enable an item' do
      visit dashboard_items_path

      within "#item-#{@hippo.id}" do
        click_button('Enable Item')
        expect(current_path).to eq(dashboard_items_path)
        expect(@hippo.reload.active).to eq(true)
      end
      expect(page).to have_content("#{@hippo.name} is now available for sale.")
    end
  end
end
