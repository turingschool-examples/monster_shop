# require 'rails_helper'
#
# RSpec.describe 'As a merchant' do
#   describe 'When I visit my item page' do
#     before :each do
#       @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, enabled: true)
#       @larry = User.create!(name: "Larry Green", address: "345 Blue Lane", city: "Blue City", state: "CA", zip: 56789, email: "green@gmail.com", password: "frogs", role: 2, merchant_id: @megan.id)
#       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@larry)
#     end
#
#     describe 'when I visit my items page' do
#       it 'has a new item button that redirects to the new item form' do
#         visit dashboard_items_path
#
#         click_button('Add new item')
#         expect(current_path).to eq new_dashboard_item_path
#       end
#
#       it 'shows a form I can submit item information on and will save the item if valid' do
#         name = 'Fairy'
#         description = "I'm a Fairy!"
#         price = 23.20
#         image = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw'
#         inventory = 1
#
#         visit new_dashboard_item_path
#
#         fill_in 'Name', with: name
#         fill_in 'Description', with: description
#         fill_in 'Price', with: price
#         fill_in 'Image', with: image
#         fill_in 'Inventory', with: inventory
#         click_button 'Create Item'
#
#         expect(current_path).to eq dashboard_item_path
#         expect(page).to have_link(name)
#         expect(page).to have_content("Description: #{new_item.description}")
#         expect(page).to have_content("Price: #{number_to_currency(price)}")
#         expect(page).to have_content("Active")
#         expect(page).to have_content("Inventory: #{inventory}")
#         expect(page).to have_content("#{new_item.name} has been saved.")
#       end
#
#
#       describe 'When I try to add incorrect information it redirects and provides a message' do
#         it 'provides an error if I do not fill in name' do
#           visit new_dashboard_item_path
#
#           fill_in 'Price', with: '23.20'
#           fill_in 'Description', with: 'I am a fairy!'
#           fill_in 'Inventory', with: '1'
#
#           click_button 'Create Item'
#
#           expect(current_path).to eq(new_dashboard_item_path)
#           expect(page).to have_content("Name can't be blank")
#         end
#
#         it 'provides an error if price is blank' do
#           visit new_dashboard_item_path
#
#           fill_in 'Name', with: 'Fairy'
#           fill_in 'Description', with: 'I am a fairy!'
#           fill_in 'Inventory', with: '1'
#
#           click_button 'Create Item'
#
#           expect(current_path).to eq(new_dashboard_item_path)
#           expect(page).to have_content("Price can't be blank")
#         end
#
#         it 'provides an error if blank' do
#           visit new_dashboard_item_path
#
#           fill_in 'Name', with: 'Fairy'
#           fill_in 'Price', with: '23.20'
#           fill_in 'Inventory', with: '1'
#
#           click_button 'Create Item'
#
#           expect(current_path).to eq(new_dashboard_item_path)
#           expect(page).to have_content("Description can't be blank")
#         end
#
#         it 'provides an error if I do not fill in inventory' do
#           visit dashboard_items_path
#
#           fill_in 'Name', with: 'Fairy'
#           fill_in 'Price', with: '23.20'
#           fill_in 'Description', with: 'I am a fairy!'
#
#           click_button 'Create Item'
#
#           expect(current_path).to eq(new_dashboard_item_path)
#           expect(page).to have_content("Inventory can't be blank")
#         end
#       end
#     end
#   end
# end

require "rails_helper"

RSpec.describe "As a merchant" do
  before :each do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, enabled: true)
    @merchant_1 = User.create!(email: "merchant1@gmail.com", password: "password1", role: 2, name: "Merchant 1", address: "1 Fake St", city: "city 1", state: "CO", zip: "12345", merchant_id: @megan.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)
  end

  describe "when I visit my items page" do
    it "has a new item button that redirects to the new item form" do
      visit dashboard_items_path

      click_link("New Item")
      expect(current_path).to eq new_dashboard_item_path
    end

    it "shows a form I can submit item information on and will save the item if valid" do
      visit dashboard_items_path

      click_link("New Item")

      fill_in("Name", with: "Item 1")
      fill_in("Price", with: "11.11")
      fill_in("Description", with: "description 1")
      fill_in("Inventory", with: "1")

      click_button "Create Item"

      new_item = Item.last

      expect(new_item.name).to eq("Item 1")
      expect(new_item.price).to eq(11.11)
      expect(new_item.description).to eq("description 1")
      expect(new_item.image).to eq("https://img.etimg.com/thumb/msid-64749432,width-643,imgsize-242955,resizemode-4/art-stealing-thief-thinkstockphotos-459021285.jpg")
      expect(new_item.inventory).to eq(1)

      expect(current_path).to eq dashboard_items_path
      expect(page).to have_content("#{new_item.name} has been saved.")

      within("#item-#{new_item.id}-info") do
        expect(page).to have_content("ID: #{new_item.id}")
        expect(page).to have_content("Name: #{new_item.name}")
        expect(page).to have_css("img[src='#{new_item.image}']")
        expect(page).to have_content("Price: $#{new_item.price}")
        expect(page).to have_content("Inventory: #{new_item.inventory}")
        expect(page).to have_button("Edit Item")
        expect(page).to have_button("Disable Item")
        expect(page).to have_button("Delete Item")
      end
    end
    describe "When I try to add incorrect information it redirects and provides a message" do
      it "provides an error if I do not fill in name" do
        visit new_dashboard_item_path

        fill_in "Price", with: "11.11"
        fill_in "Description", with: "description 1"
        fill_in "Inventory", with: "1"

        click_button "Create Item"

        expect(current_path).to eq(new_dashboard_item_path)
        expect(page).to have_content("Name can't be blank")
      end

      it "provides an error if I do not fill in price" do
        visit new_dashboard_item_path

        fill_in "Name", with: "Item 1"
        fill_in "Description", with: "description 1"
        fill_in "Inventory", with: "1"

        click_button "Create Item"

        expect(current_path).to eq(new_dashboard_item_path)
        expect(page).to have_content("Price can't be blank")
      end

      it "provides an error if I do not fill in description" do
        visit new_dashboard_item_path

        fill_in "Name", with: "Item 1"
        fill_in "Price", with: "11.11"
        fill_in "Inventory", with: "1"

        click_button "Create Item"

        expect(current_path).to eq(new_dashboard_item_path)
        expect(page).to have_content("Description can't be blank")
      end

      it "provides an error if I do not fill in inventory" do
        visit new_dashboard_item_path

        fill_in "Name", with: "Item 1"
        fill_in "Price", with: "11.11"
        fill_in "Description", with: "description 1"

        click_button "Create Item"

        expect(current_path).to eq(new_dashboard_item_path)
        expect(page).to have_content("Inventory can't be blank")
      end
    end
  end
end
