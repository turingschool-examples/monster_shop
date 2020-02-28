require 'rails_helper'

RSpec.describe 'Admin Merchant' do
  describe "As an Admin User, when I visit the merchant index page '/merchants'" do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @admin123 = User.create!(user_name: "andrew@gmail.com", password: "thinking123", role: 2, name: "Andrew", address: "333 Market St", city: "Denver", state: "CO", zip: 80012 )
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @mermaid = @megan.items.create!(name: 'Mermaid', description: "I'm a Mermaid!", price: 500, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 13 )
      @dragon = @megan.items.create!(name: 'Dragon', description: "I'm a Dragon", price: 2000, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @fairy = @megan.items.create!(name: 'Fairy', description: "I'm a Fairy", price: 25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 66 )

      visit root_path
      click_link 'Login'
      fill_in "User name", with: "andrew@gmail.com"
      fill_in "Password", with: "thinking123"
      click_button "Log In"
      click_link 'Merchants'
    end

      it "I click a merchant's name then my URI route should be '/admin/merchants/6'" do
        click_link(@megan.name)

        expect(current_path).to eq("/admin/merchants/#{@megan.id}")
      end

    describe "I see a 'disable' button to any merchants who are not yet disabled" do
      it "When I click that button, I am returned to admin's merchant index where the account is disabled and see a flash message" do
        expect(page).to have_button('Disable')
        click_button 'Disable'
        expect(current_path).to eq(merchants_path)
        expect(page).to have_content("#{@megan.name} is now disabled.")
      end

      it "Then all of that merchant's items should be deactivated" do
        click_button 'Disable'
        @ogre.reload

        expect(@ogre.active).to eq(false)
      end
    end

    describe "I see a 'enable' button to any merchants who are disabled" do
      it "When I click that button, I am returned to admin's merchant index where the account is enabled and see a flash message" do
        click_button 'Disable'
        expect(page).to have_button('Enable')
        click_button 'Enable'
        expect(current_path).to eq(merchants_path)
        expect(page).to have_content("#{@megan.name} is now enabled.")
      end

      it "Then all of that merchant's items should be activated" do
        click_button 'Disable'
        click_button 'Enable'
        @ogre.reload

        expect(@ogre.active).to eq(true)
      end
    end
  end
end
