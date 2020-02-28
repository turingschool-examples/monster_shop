require 'rails_helper'

RSpec.describe "Admin Dashboard" do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )

      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 75, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @admin = User.create!(user_name: "andrew@gmail.com", password: "thinking123", role: 2, name: "Andrew", address: "333 Market St", city: "Denver", state: "CO", zip: 80012 )
      @nathan = User.create!(user_name: "nthomas", password: "123",  password_confirmation: "123", name: "Nathan Thomas", address: "123 Main St", city: "Gunbarrel", state: "Colorado", zip: 80301)
      @andrew = User.create!(user_name: "ajohnson", password: "123",  password_confirmation: "123", name: "Andrew Johnson", address: "123 Main St", city: "Lakewood", state: "Colorado", zip: 80401)
      @jori = User.create!(user_name: "jpeterson", password: "123",  password_confirmation: "123", name: "Jori Peterson", address: "123 Main St", city: "Westminster", state: "Colorado", zip: 80791)
      @will = User.create!(user_name: "wthomson", password: "123",  password_confirmation: "123", name: "Will Thompson", address: "123 Main St", city: "Longmont", state: "Colorado", zip: 80501)
      @merchant_admin = User.create!(user_name: "nathan@gmail.com", password: "password123", role: 1, name: "Nathan", address: "123 Market St", city: "Denver", state: "CO", zip: 80012, merchant_id: @megan.id )

      @order_1 = @nathan.orders.create!

      @order_item_1 = @order_1.order_items.create!(price: @ogre.price, quantity: 3, item: @ogre)
      @order_item_2 = @order_1.order_items.create!(price: @giant.price, quantity: 1000, item: @giant)
      @order_item_3 = @order_1.order_items.create!(price: @hippo.price, quantity: 2, item: @hippo)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit admin_dashboard_path
    end

    describe "When I login to my account and click the link Admin Dashboard" do
      it  "I am taken a dashboard page with all active orders" do
      visit root_path
      click_link "Admin Dashboard"
      expect(current_path).to eq(admin_dashboard_path)
      end

      it "For each order I see the following information: the user who placed the order, which links to admin view of user profile, order id, date the order was created" do

        expect(page).to have_link(@nathan.user_name)
        expect(page).to have_content(@order_1.id)
        expect(page).to have_content(@order_1.created_at.to_formatted_s(:short))

      end
     it  "I see a ship button next to all packeged orders. When I press the ship button, the status is changed to shipped and the user cannont cancel the order." do

       expect(page).to have_button("Ship Order")
       click_button "Ship Order"
       expect(page).to have_content("shipped")
     end
   end
 end
