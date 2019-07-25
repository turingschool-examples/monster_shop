require 'rails_helper'

RSpec.describe Merchant do
  describe 'Relationships' do
    it {should have_many :items}
    it {should have_many(:order_items).through(:items)}
  end

  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe 'Instance Methods' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @sal = Merchant.create!(name: 'Sals Salamanders', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @meg = User.create!(name: 'Meg', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'meg@gmail.com', password: 'fish')
      @meg_2 = User.create!(name: 'Meg2', address: '123 Main St', city: 'Denver', state: 'IA', zip: 80218, email: 'meg_2@gmail.com', password: 'fish')
      @order_1 = @meg.orders.create!
      @order_2 = @meg_2.orders.create!
      @order_3 = @meg_2.orders.create!(status: 0)
      @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
      @order_1.order_items.create!(item: @hippo, price: @hippo.price, quantity: 3)
      @order_2.order_items.create!(item: @giant, price: @hippo.price, quantity: 2)
      @order_2.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
      @order_3.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
    end

    it '.item_count' do
      expect(@megan.item_count).to eq(2)
      expect(@brian.item_count).to eq(1)
      expect(@sal.item_count).to eq(0)
    end

    it '.average_item_price' do
      expect(@megan.average_item_price.round(2)).to eq(35.13)
      expect(@brian.average_item_price.round(2)).to eq(50.00)
    end

    it '.distinct_cities' do
      expect(@megan.distinct_cities).to eq(['Denver, CO', 'Denver, IA'])
      @meg_2.update(enabled: false)
      expect(@megan.distinct_cities).to eq(['Denver, CO'])
    end

    it '.items_active' do
      expect(@ogre.active).to eq(true)
      expect(@giant.active).to eq(true)

      @megan.items_inactive

      expect(@ogre.active).to eq(false)
      expect(@giant.active).to eq(false)

      @megan.items_active

      expect(@ogre.active).to eq(true)
      expect(@giant.active).to eq(true)
    end

    it '.pending_orders' do
      megans_orders = @megan.pending_orders

      expect(megans_orders.first).to eq(@order_1)
      expect(megans_orders.last).to eq(@order_2)
      expect(megans_orders.first.n_items).to eq(2)
      expect(megans_orders.first.g_total).to eq(40.50)
      expect(megans_orders.last.n_items).to eq(4)
      expect(megans_orders.last.g_total).to eq(140.50)

      @meg_2.update(enabled: false)
      megans_orders = @megan.pending_orders

      expect(megans_orders.first).to eq(@order_1)
      expect(megans_orders.last).to eq(@order_1)
    end

    it '.all_names' do
      expect(Merchant.all_names).to eq(Merchant.pluck(:name))
    end
  end
end
