require 'rails_helper'

RSpec.describe "Merchant (Merchant_admin role: 1) Can add an item" do
  describe "As a merchant" do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @merchant_admin = User.create!(user_name: "nathan@gmail.com", password: "password123", role: 1, name: "Nathan", address: "123 Market St", city: "Denver", state: "CO", zip: 80012, merchant_id: @megan.id )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_admin)
    end

    it 'when I visit my items page I see a link to add a new item. When I click the link I see a form where I can add new info about an item' do
      visit "/merchants/#{@megan.id}/items"
      click_link("Add New Item")
      expect(current_path).to eq(new_merchant_admins_item_path)
    end

    it 'when I submit valid information and submit the form I am redirected to my items page where I see a flash message that says my new item is saved and I see that my item is enabled and for sale.' do
      visit "/merchants/#{@megan.id}/items"
      click_link("Add New Item")

      fill_in('Name', with:'Bigfoot')
      fill_in('Description', with: 'Illusive, tall, hairy, and has big feet')
      fill_in('Image', with:'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw')
      fill_in('Price', with: 10999)
      fill_in('Inventory', with: 1)
      click_on("Create Item")

      expect(current_path).to eq("/merchants/#{@megan.id}/items")
      expect(page).to have_link("Bigfoot")
      expect(page).to have_content("#{@bigfoot} has been saved.")
    end

    it 'only the image can be left blank and a placeholder image is displayed if that field is left blank' do
      visit "/merchants/#{@megan.id}/items"
      click_link("Add New Item")

      fill_in('Name', with:'Bigfoot')
      fill_in('Description', with: 'Illusive, tall, hairy, and has big feet')
      fill_in('Image', with:'')
      fill_in('Price', with: 10999)
      fill_in('Inventory', with: 1)
      click_on("Create Item")
      expect(current_path).to eq("/merchants/#{@megan.id}/items")
      expect(page).to have_xpath("//img[contains(@src,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw')]")
    end

    it 'name and description, cannont be blank' do
      visit "/merchants/#{@megan.id}/items"
      click_link("Add New Item")

      fill_in('Name', with:'')
      fill_in('Description', with:'')
      fill_in('Image', with:'')
      fill_in('Price', with: 10999)
      fill_in('Inventory', with: 1)
      click_on("Create Item")
      expect(current_path).to eq("/merchant_admins/items")
      expect(page).to have_content("can't be blank")
    end

    it 'price and inventory must be valid numbers' do
      visit "/merchants/#{@megan.id}/items"
      click_link("Add New Item")

      fill_in('Name', with:'Bigfoot')
      fill_in('Description', with: 'Illusive, tall, hairy, and has big feet')
      fill_in('Image', with:'')
      fill_in('Price', with: -3)
      fill_in('Inventory', with: -42 )
      click_on("Create Item")
      expect(current_path).to eq("/merchant_admins/items")
      expect(page).to have_content("must be greater than 0")
      expect(page).to have_content("must be greater than or equal to 0")
    end

    it 'a new item cannont be made if fields are missing or incorrect (except image). I am returnted to the form with all fields repopulated with my previous data' do
      visit "/merchants/#{@megan.id}/items"
      click_link("Add New Item")

      fill_in('Name', with:'Bigfoot')
      fill_in('Description', with: '')
      fill_in('Image', with:'')
      fill_in('Price', with: -300.0)
      fill_in('Inventory', with: 1)
      click_on("Create Item")

      expect(current_path).to eq("/merchant_admins/items")
      expect(find_field('Name').value).to eq 'Bigfoot'
      expect(find_field('Description').value).to eq ''
      expect(find_field('Image').value).to eq ''
      expect(find_field('Price').value).to eq '-300.0'
      expect(find_field('Inventory').value).to eq '1'
    end
  end
end
