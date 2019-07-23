require 'rails_helper'

RSpec.describe 'Merchant' do
  describe 'I visit my dashboard' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @megan.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @larry = User.create!(name: "Larry Green", address: "345 Blue Lane", city: "Blue City", state: "CA", zip: 56789, email: "green@gmail.com", password: "frogs", role: 2, merchant_id: @megan.id)
      @customer = User.create!(name: "Customer McCustomer", address: "345 Blue Lane", city: "Blue City", state: "CA", zip: 56789, email: "customer@gmail.com", password: "shopper", role: 0)

      @order_1 = @customer.orders.create!
      @order_2 = @customer.orders.create!

      @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
      @order_2.order_items.create!(item: @giant, price: @giant.price, quantity: 1)
      @order_2.order_items.create!(item: @hippo, price: @hippo.price, quantity: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@larry)
      visit merchant_dashboard_path
    end

    it 'I can see my profile data' do
      expect(page).to have_content(@megan.name)

      within '.address' do
        expect(page).to have_content(@megan.address)
        expect(page).to have_content("#{@megan.city} #{@megan.state} #{@megan.zip}")
      end
    end

    it 'I can see my pending orders' do
      expect(page).to have_content(@megan.name)

      within "#order-#{@order_1.id}" do
        expect(page).to have_link("Order ##{@order_1.id}")
        expect(page).to have_content("Ordered On: #{@order_1.created_at}")
        expect(page).to have_content("Number of Items: #{@order_1.num_items}")
        expect(page).to have_content("Total: #{@order_1.grand_total}")
      end
    end

    it 'I can see a link to my items' do
      expect(page).to have_button('Items')
    end
  end
end
