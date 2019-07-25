# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As an Admin' do
  describe "when I visit my items page" do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5)
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
      @hippo = @megan.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: false, inventory: 3 )
      @meg = User.create!(name: 'Megan M', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'meg@gmail.com', password: 'fish')
      @larry = User.create!(name: 'Larry Green', address: '345 Blue Lane', city: 'Blue City', state: 'CA', zip: 56_789, email: 'green@gmail.com', password: 'frogs', role: 2, merchant_id: @megan.id)
      @order2 = @larry.orders.create!
      @order2.order_items.create!(item: @giant, price: @giant.price, quantity: 2)
      @admin = User.create!(name: "Admin", address: "123 Cheese Lane", city: "Cheese City", state: "CO", zip: 12345, email: "admin@gmail.com", password: "rabbit", role: 3)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit admin_merchant_items_path(@megan)
    end

    it 'shows a link to add a new item' do
      expect(page).to have_button('New Item')
    end

    it 'shows merchant items' do
      within "#item-#{@ogre.id}" do
        expect(page).to have_link(@ogre.name)
        expect(page).to have_content(@ogre.description)
        expect(page).to have_content("Price: #{number_to_currency(@ogre.price)}")
        expect(page).to have_content("Inventory: #{@ogre.inventory}")
        expect(page).to have_css("img[src*='#{@ogre.image}']")
        expect(page).to have_button('Delete Item')
      end

      within "#item-#{@giant.id}" do
        expect(page).to have_link(@giant.name)
        expect(page).to have_content(@giant.description)
        expect(page).to have_content("Price: #{number_to_currency(@giant.price)}")
        expect(page).to have_content("Inventory: #{@giant.inventory}")
        expect(page).to have_css("img[src*='#{@giant.image}']")
      end
    end

    it 'shows a button to disable and enable items' do
      within("#item-#{@ogre.id}") do
        expect(page).to have_button('Disable Item')
      end
      within("#item-#{@giant.id}") do
        expect(page).to have_button('Disable Item')
      end
    end

    it 'does not show a button to delete an item if ordered' do
      within("#item-#{@giant.id}") do
        expect(page).to_not have_button('Delete Item')
      end
    end
  end
end
