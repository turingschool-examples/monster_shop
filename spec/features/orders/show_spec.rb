require 'rails_helper'

RSpec.describe "Order Show Page", type: :feature do
  describe "As a registered user, when I visit my profile orders page" do
    describe "I click on a link for order's show page" do
      before :each do
        @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
        @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
        @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
        @nathan = User.create!(user_name: "nthomas", password: "123",  password_confirmation: "123", name: "Nathan Thomas", address: "123 Main St", city: "Gunbarrel", state: "Colorado", zip: 80301)
        @order_1 = @nathan.orders.create!
        @order_item_1 = @order_1.order_items.create!(price: @ogre.price, quantity: 1, item: @ogre)

        visit root_path
        click_link "Login"
        fill_in "User name", with: "nthomas"
        fill_in "Password", with: "123"
        click_button "Log In"
        visit item_path(@ogre)
        click_button 'Add to Cart'
        visit '/cart'
        click_button 'Check Out'
        visit profile_path
        click_link 'My Orders'
        click_link "Order ID: #{@order_1.id}"
      end

      it "My url is now something like '/profile/orders/15' and I see all the information about the order" do

        expect(page).to have_content("Order ID: #{@order_1.id}")
        expect(page).to have_content("Order Created: #{@order_1.created_at}")
        expect(page).to have_content("#{@ogre.name}")
        expect(page).to have_content("Description: #{@ogre.description}")
        expect(page).to have_content("Last Updated: #{@order_1.updated_at}")
        expect(page).to have_content("Order Status: #{@order_1.status}")
        expect(page).to have_content("Total Quantity of Items: #{@order_1.total_quantity}")
        expect(page).to have_content("Grand Total: #{number_to_currency(@order_1.grand_total)}")
      end

      it "I see a link to cancel the order only if the order is still pending" do
        expect(page).to have_button('Cancel Order')
        click_button 'Cancel Order'
        expect(current_path).to eq(profile_path)
        expect(page).to have_content("That order has been cancelled.")
        click_link 'My Orders'
        expect(page).to have_content("Order Status: cancelled")
      end
    end
  end
end
