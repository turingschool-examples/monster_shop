require 'rails_helper'

RSpec.describe 'Admin' do
  describe 'go to merchant index page click on merchant name' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      # @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      # @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      # @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      # @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @larry = User.create!(name: "Larry Green", address: "345 Blue Lane", city: "Blue City", state: "CA", zip: 56789, email: "green@gmail.com", password: "frogs", role: 2, merchant_id: @megan.id)

      # @order_1 = @meg.orders.create!
      # @order_2 = @meg2.orders.create!
      #
      # @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
      # @order_2.order_items.create!(item: @giant, price: @hippo.price, quantity: 2)
      # @order_2.order_items.create!(item: @ogre, price: @hippo.price, quantity: 2)
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

    it 'I can see a link to my items' do
      expect(page).to have_button('Items')
    end

    # it 'I see merchant statistics' do
    #   within '.statistics' do
    #     expect(page).to have_content("Item Count: #{@megan.item_count}")
    #     expect(page).to have_content("Average Item Price: #{number_to_currency(@megan.average_item_price)}")
    #     expect(page).to have_content("Cities Served:\nDenver, CO\nDenver, IA")
    #   end
    # end
    #
    # it 'I see stats for merchants with items, but no orders' do
    #   within '.statistics' do
    #     expect(page).to have_content("Item Count: #{@megan.item_count}")
    #     expect(page).to have_content("Average Item Price: #{number_to_currency(@megan.average_item_price)}")
    #   end
    # end
  end
end
