require 'rails_helper'

RSpec.describe 'Admin' do
  describe "I visit the merchant's index page and see their city and state" do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @larry = User.create!(name: "Larry Green", address: "345 Blue Lane", city: "Blue City", state: "CA", zip: 56789, email: "green@gmail.com", password: "frogs", role: "admin")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@larry)
      visit admin_merchant_index_path 
    end

    it "The merchant's name is a link to their merchant dashboard" do
      click_link "Megan's Marmalades"

      expect(current_path).to eq(admin_merchant_show)
    end

    it "I see a disable button next to a merchant who is enabled" do

      expect(page).to have_button('enabled')
    end

    it "I see an enable button next to a merchant who is disabled" do

      expect(page).to have_button('disabled')
    end
  end
end
