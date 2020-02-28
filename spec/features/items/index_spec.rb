require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Item Index Page' do
  describe 'As a visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @unicorn = @brian.items.create!(name: 'Unicorn', description: "I'm a Unicorn!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: false, inventory: 8 )

    end
    it 'I can see a list of all items' do
      visit '/items'

      within "#item-#{@ogre.id}" do
        expect(page).to have_link(@ogre.name)
        expect(page).to have_content(@ogre.description)
        expect(page).to have_content("Price: #{number_to_currency(@ogre.price)}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@ogre.inventory}")
        expect(page).to have_content("Sold by: #{@megan.name}")
        expect(page).to have_css("img[src*='#{@ogre.image}']")
        expect(page).to have_link(@megan.name)
      end

      within "#item-#{@giant.id}" do
        expect(page).to have_link(@giant.name)
        expect(page).to have_content(@giant.description)
        expect(page).to have_content("Price: #{number_to_currency(@giant.price)}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@giant.inventory}")
        expect(page).to have_content("Sold by: #{@megan.name}")
        expect(page).to have_css("img[src*='#{@giant.image}']")
        expect(page).to have_link(@megan.name)
      end

      within "#item-#{@hippo.id}" do
        expect(page).to have_link(@hippo.name)
        expect(page).to have_content(@hippo.description)
        expect(page).to have_content("Price: #{number_to_currency(@hippo.price)}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@hippo.inventory}")
        expect(page).to have_content("Sold by: #{@brian.name}")
        expect(page).to have_css("img[src*='#{@hippo.image}']")
        expect(page).to have_link(@brian.name)
      end
    end
  end

  describe 'as a user' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @mermaid = @megan.items.create!(name: 'Mermaid', description: "I'm a Mermaid!", price: 500, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 13 )
      @dragon = @megan.items.create!(name: 'Dragon', description: "I'm a Dragon", price: 2000, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @fairy = @megan.items.create!(name: 'Fairy', description: "I'm a Fairy", price: 25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 66 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @warewolf = @brian.items.create!(name: 'Warewolf', description: "I'm a Warewolf", price: 600, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 13 )
      @yeti = @brian.items.create!(name: 'Yeti', description: "I'm a Yeti", price: 34, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 34 )
      @troll = @brian.items.create!(name: 'Troll', description: "I'm a Troll", price: 55, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 20 )
      @ghoul = @brian.items.create!(name: 'Ghoul', description: "I'm a Ghoul", price: 99, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @unicorn = @brian.items.create!(name: 'Unicorn', description: "I'm a Unicorn!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: false, inventory: 8 )

      @user_1 = User.create!(name: "Lucifer", user_name: "iheartmonsters", password: "Monsters!", address: "666 Hells Gate", city: "Hell", state: "LA", zip: "71220")
      @user_2 = User.create!(name: "Kyle", user_name: "monsterlover", password: "mynameiskyle", address: "some corner store", city: "Monsterville", state: "SD", zip:"54321")

      @order_1 = @user_1.orders.create!
      @order_2 = @user_2.orders.create!

      @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
      @order_1.order_items.create!(item: @giant, price: @giant.price, quantity: 2)
      @order_1.order_items.create!(item: @dragon, price: @dragon.price, quantity: 2)
      @order_1.order_items.create!(item: @ghoul, price: @ghoul.price, quantity: 2)
      @order_1.order_items.create!(item: @fairy, price: @fairy.price, quantity: 2)

      @order_2.order_items.create!(item: @yeti, price: @yeti.price, quantity: 1)
      @order_2.order_items.create!(item: @warewolf, price: @warewolf.price, quantity: 1)
      @order_2.order_items.create!(item: @mermaid, price: @mermaid.price, quantity: 1)
      @order_2.order_items.create!(item: @hippo, price: @hippo.price, quantity: 1)

    end

    it 'I can see all items except for disabled items' do
      visit '/items'
      expect(page).to have_content(@ogre.name)
      expect(page).to have_no_content(@unicorn.name)
      expect(page).to have_no_content(@unicorn.description)
    end

    it 'the item image is a link to the show page for that item' do
      visit '/items'
      within "#item-#{@ogre.id}" do
        click_link('image')
      end
      expect(current_path).to eq(item_path(@ogre.id))
    end

    it 'I see stats for the 5 most popular items and 5 least popular items, plus the quantity' do
      visit '/items'

      expect(page).to have_content("Most Popular Items:")
      expect(page).to have_content("Ghoul: 2")
      expect(page).to have_content("Fairy: 2")
      expect(page).to have_content("Dragon: 2")
      expect(page).to have_content("Giant: 2")
      expect(page).to have_content("Ogre: 2")

      expect(page).to have_content("Least Popular Items:")
      expect(page).to have_content("Yeti: 1")
      expect(page).to have_content("Warewolf: 1")
      expect(page).to have_content("Hippo: 1")
      expect(page).to have_content("Mermaid: 1")
      expect(page).to have_content("Ogre: 2")
    end
  end
end
