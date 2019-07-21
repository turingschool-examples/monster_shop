require 'rails_helper'

RSpec.describe 'Admin' do
  describe 'I can go to merchant index page click on merchant name' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @sal = Merchant.create!(name: 'Sals Salamanders', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @meg = User.create!(name: 'Megan M', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'meg@gmail.com', password: 'fish' )
      @larry = User.create!(name: "Larry Green", address: "345 Blue Lane", city: "Blue City", state: "CA", zip: 56789, email: "green@gmail.com", password: "frogs", role: "admin")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@larry)
      visit admin_merchant_show_path(@megan)
    end

    describe 'I can see that merchants dashboard' do
      it 'my path is /admin/merchants/:merchant_id' do
        expect(current_path).to eq(admin_merchant_show_path(@megan))
      end
    end

    it 'I see merchant name and address' do
      visit "admin/merchants/#{@megan.id}"

      expect(page).to have_content(@megan.name)

      within '.address' do
        expect(page).to have_content(@megan.address)
        expect(page).to have_content("#{@megan.city} #{@megan.state} #{@megan.zip}")
      end
    end

    it 'I see a link to this merchants items' do
      visit "admin/merchants/#{@megan.id}"

      click_link "Items"

      expect(current_path).to eq("admin/items")
    end

    it 'I see merchant statistics' do
      visit "admin/merchants/#{@megan.id}"

      within '.statistics' do
        expect(page).to have_content("Item Count: #{@megan.item_count}")
        expect(page).to have_content("Average Item Price: #{number_to_currency(@megan.average_item_price)}")
        expect(page).to have_content("Cities Served:\nDenver, CO\nDenver, IA")
      end
    end

    it 'I see stats for merchants with items, but no orders' do
      visit "admin/merchants/#{@brian.id}"

      within '.statistics' do
        expect(page).to have_content("Item Count: #{@brian.item_count}")
        expect(page).to have_content("Average Item Price: #{number_to_currency(@brian.average_item_price)}")
        expect(page).to have_content("This Merchant has no Orders!")
      end
    end

    it 'I see stats for merchants with no items or orders' do
      visit "admin/merchants/#{@sal.id}"

      within '.statistics' do
        expect(page).to have_content('This Merchant has no Items, or Orders!')
      end
    end

    # it "I can toggle a button to enable or disable a merchant" do
    #   visit admin_merchant_index_path
    #   click_button 'Disable Merchant'
    #
    #   expect(page).to have_content("The account for #{@megan.name} is now disabled")
    #   expect(@megan.reload.enabled).to eq(false)
    #   expect(current_path).to eq(admin_merchant_index_path)
    #   expect(page).to have_button('Enable Merchant')
    #
    #   visit admin_merchant_index_path
    #   click_button 'Enable Merchant'
    #
    #   expect(page).to have_content("The account for #{@megan.name} is now enabled")
    #   expect(@megan.reload.enabled).to eq(true)
    #   expect(current_path).to eq(admin_merchant_index_path)
    #   expect(page).to have_button('Disable Merchant')
    # end
  end
end
