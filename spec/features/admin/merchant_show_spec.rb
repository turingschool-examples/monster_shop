require 'rails_helper'

RSpec.describe 'Admin' do
  describe 'go to merchant index page click on merchant name' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @meg = User.create!(name: 'Megan M', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'meg@gmail.com', password: 'fish' )
      @larry = User.create!(name: "Larry Green", address: "345 Blue Lane", city: "Blue City", state: "CA", zip: 56789, email: "green@gmail.com", password: "frogs", role: "admin")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@larry)
      visit admin_merchant_show_path(@megan)
    end

    describe 'I can see everything a merchant would' do
      it 'my path is /admin/merchants/:merchant_id' do
        expect(current_path).to eq(admin_merchant_show_path(@megan))
      end
    end

    it "I can toggle a button to enable or disable a merchant" do
      visit admin_merchant_show_path(@megan.id)
      click_button 'Disable Merchant'

      expect(page).to have_button('Enable Merchant')

      visit admin_merchant_show_path(@megan.id)
      click_button 'Enable Merchant'

      expect(page).to have_button('Disable Merchant')
    end
  end
end
