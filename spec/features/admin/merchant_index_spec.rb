require 'rails_helper'

RSpec.describe 'Admin' do
  describe "I visit the merchant's index page and see their city and state" do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, enabled: true)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218, enabled: true)
      @larry = User.create!(name: "Larry Green", address: "345 Blue Lane", city: "Blue City", state: "CA", zip: 56789, email: "green@gmail.com", password: "frogs", role: "admin")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@larry)
      visit admin_merchant_index_path
    end

    it "I see merchant name, city, and state displayed on the page" do

      expect(page).to have_link("Megans Marmalades")
      expect(page).to have_content(@megan.city)
      expect(page).to have_content(@megan.state)
    end

    it "The merchant's name is a link to their merchant dashboard" do
      click_link "Megans Marmalades"

      expect(current_path).to eq(admin_merchant_show_path(@megan.id))
    end

    it "A merchant is enabled by default" do
      visit admin_merchant_show_path(@megan.id)

      within('#enabled') { expect(page).to have_content(true) }
      expect(page).to have_button('disable')
    end

    # it "I see a disable button next to a merchant who is enabled" do
    #
    # end
    #
    # it "I see an enable button next to a merchant who is disabled" do
    #
    #   expect(page).to have_button('enable')
    # end
  end
end
