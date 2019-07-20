require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Item Index Page' do
  describe 'As a visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @alex = User.create!(name: "Alex Hennel", address: "123 Straw Lane", city: "Straw City", state: "CO", zip: 12345, email: "straw@gmail.com", password: "fish", role: 0)

      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @elephant = @brian.items.create!(name: 'Elphant', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @bear = @brian.items.create!(name: 'Bear', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @order_1 = @alex.orders.create!
      @order_1.order_items.create(item: @ogre, quantity: 50, price: @ogre.price)
      @order_1.order_items.create(item: @giant, quantity: 49, price: @giant.price)
      @order_1.order_items.create(item: @hippo, quantity: 45, price: @hippo.price)
      @order_1.order_items.create(item: @elephant, quantity: 55, price: @elephant.price)
      @order_1.order_items.create(item: @bear, quantity: 40, price: @bear.price)

      @frog = @brian.items.create!(name: 'Frog', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @dog = @brian.items.create!(name: 'Dog', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @cat = @brian.items.create!(name: 'Cat', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @horse = @brian.items.create!(name: 'Horse', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @donkey = @brian.items.create!(name: 'Donkey', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @order_2 = @alex.orders.create!
      @order_1.order_items.create(item: @frog, quantity: 5, price: @frog.price)
      @order_1.order_items.create(item: @dog, quantity: 6, price: @dog.price)
      @order_1.order_items.create(item: @cat, quantity: 6, price: @cat.price)
      @order_1.order_items.create(item: @horse, quantity: 7, price: @horse.price)
      @order_1.order_items.create(item: @donkey, quantity: 7, price: @donkey.price)

      @gorilla = @brian.items.create!(name: 'Gorilla', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @order_2 = @alex.orders.create!
      @order_1.order_items.create(item: @gorilla, quantity: 10, price: @gorilla.price)
    end

    it 'I can see item statistics' do
      visit '/items'

      within "#top-five" do
        expect(page.all('h3')[0]).to have_content("Item: #{@elephant.name}")
        expect(page.all('h4')[0]).to have_content("Quantity Ordered: 55")
        expect(page.all('h3')[1]).to have_content("Item: #{@ogre.name}")
        expect(page.all('h4')[1]).to have_content("Quantity Ordered: 50")
        expect(page.all('h3')[2]).to have_content("Item: #{@giant.name}")
        expect(page.all('h4')[2]).to have_content("Quantity Ordered: 49")
        expect(page.all('h3')[3]).to have_content("Item: #{@hippo.name}")
        expect(page.all('h4')[3]).to have_content("Quantity Ordered: 45")
        expect(page.all('h3')[4]).to have_content("Item: #{@bear.name}")
        expect(page.all('h4')[4]).to have_content("Quantity Ordered: 40")
        expect(page).to_not have_content(@frog.name)
        expect(page).to_not have_content(@dog.name)
        expect(page).to_not have_content(@cat.name)
        expect(page).to_not have_content(@horse.name)
        expect(page).to_not have_content(@donkey.name)
        expect(page).to_not have_content(@gorilla.name)
      end

      within "#bottom-five" do
        expect(page.all('h3')[0]).to have_content("Item: #{@frog.name}")
        expect(page.all('h4')[0]).to have_content("Quantity Ordered: 5")
        expect(page.all('h3')[1]).to have_content("Item: #{@cat.name}")
        expect(page.all('h4')[1]).to have_content("Quantity Ordered: 6")
        expect(page.all('h3')[2]).to have_content("Item: #{@dog.name}")
        expect(page.all('h4')[2]).to have_content("Quantity Ordered: 6")
        expect(page.all('h3')[3]).to have_content("Item: #{@donkey.name}")
        expect(page.all('h4')[3]).to have_content("Quantity Ordered: 7")
        expect(page.all('h3')[4]).to have_content("Item: #{@horse.name}")
        expect(page.all('h4')[4]).to have_content("Quantity Ordered: 7")
        expect(page).to_not have_content(@elephant.name)
        expect(page).to_not have_content(@ogre.name)
        expect(page).to_not have_content(@giant.name)
        expect(page).to_not have_content(@hippo.name)
        expect(page).to_not have_content(@bear.name)
        expect(page).to_not have_content(@gorilla.name)
      end
    end
  end
end
