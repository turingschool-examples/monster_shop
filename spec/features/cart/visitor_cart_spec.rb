require 'rails_helper'

RSpec.describe "Visitor Cannot Checkout" do
  describe "As a Visitor" do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    end

    it "When I try to checkout, I get info on how to register/log in" do

			visit item_path(@ogre)
			click_button 'Add to Cart'

			visit cart_path

      expect(current_path).to eq(cart_path)

      expect(page).to have_content("You must register or log in to continue")
      expect(page).to have_link("register")
      expect(page).to have_link("log in")

			expect(page).not_to have_button("Check Out")
    end
	end
end
