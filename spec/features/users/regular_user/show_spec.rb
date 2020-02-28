require 'rails_helper'

RSpec.describe do
  describe "User Show Page" do
    before :each do
      @nathan = User.create!(user_name: "nthomas", password: "123",  password_confirmation: "123", name: "Nathan Thomas", address: "123 Main St", city: "Gunbarrel", state: "Colorado", zip: 80301)
      visit root_path
      click_link "Login"
      fill_in "User name", with: "nthomas"
      fill_in "Password", with: "123"
      click_button "Log In"
    end

    describe "As a registered user" do
      describe "When I visit my profile page" do
        it "then I see all of my profile data on the page except my password" do
          expect(page).to have_content("Nathan Thomas")
          expect(page).to have_content("Address: 123 Main St")
          expect(page).to have_content("City: Gunbarrel")
          expect(page).to have_content("State: Colorado")
          expect(page).to have_content("Zip: 80301")
          expect(page).to have_link("Edit Profile")
          end

        it "If have orders placed in the system, then I see a link on my profile page called 'My Orders', when I click the link my URI path is '/profile/orders'" do
          @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
          @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
          @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
          @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
          @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

          visit item_path(@ogre)
          click_button 'Add to Cart'
          visit '/cart'
          click_button 'Check Out'
          visit profile_path

          expect(page).to have_content('My Orders')
          click_link 'My Orders'
          expect(current_path).to eq(profile_orders_path)
        end

        it "If I do not have any orders, I do not see the 'My Orders' link" do
          rick = User.create!(user_name: "Moranis", password: "123",  password_confirmation: "123", name: "Rick Moranis", address: "I Shrunk the Kids", city: "Honey", state: "Colorado", zip: 20202)

          click_button 'Logout'

          visit root_path
          click_link "Login"
          fill_in "User name", with: "Moranis"
          fill_in "Password", with: "123"
          click_button "Log In"

          visit profile_path
          expect(page).to_not have_content('My Orders')
        end

        it "I see every order I've made with all the information" do
          @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
          @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
          @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
          @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
          @order_1 = @nathan.orders.create!
          @order_item_1 = @order_1.order_items.create!(price: @ogre.price, quantity: 1, item: @ogre)

          visit item_path(@ogre)
          click_button 'Add to Cart'
          visit item_path(@giant)
          click_button 'Add to Cart'
          visit '/cart'
          click_button 'Check Out'
          visit profile_path
          click_link 'My Orders'

          expect(page).to have_content("Order ID: #{@order_1.id}")
          expect(page).to have_content("Order Status: #{@order_1.status}")
          expect(page).to have_content("Last Updated: #{@order_1.updated_at}")
          expect(page).to have_content("Order Placed: #{@order_1.created_at}")
          expect(page).to have_content("Total Quantity of Items: #{@order_1.total_quantity}")
          expect(page).to have_content("Grand Total: #{number_to_currency(@order_1.grand_total)}")
        end
      end
    end
  end
end
