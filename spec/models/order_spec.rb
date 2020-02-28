require 'rails_helper'

RSpec.describe Order do
  describe 'relationships' do
    it {should have_many :order_items}
    it {should have_many(:items).through(:order_items)}
    it {should belong_to :user}
  end

  describe 'validations' do
    it {should validate_presence_of :status}
  end

  describe 'instance methods' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @user_1 = User.create!(name: "Santi", user_name: "user_1_email@emailplace.com", password: "test", role: 0, address: "123 Donut St", city: "Denver", state: "CO", zip: 22222)
      @order_1 = @user_1.orders.create!
      @order_2 = @user_1.orders.create!
      @oi_1 = @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
      @oi_2 = @order_1.order_items.create!(item: @hippo, price: @hippo.price, quantity: 3)
      @oi_3 = @order_2.order_items.create!(item: @hippo, price: @hippo.price, quantity: 2, fulfilled: true )
    end

    it '.grand_total' do
      expect(@order_1.grand_total).to eq(190.5)
      expect(@order_2.grand_total).to eq(100)
    end

    it '.total_quantity' do
      expect(@order_1.total_quantity).to eq(5)
      expect(@order_2.total_quantity).to eq(2)
    end

    it '.cancel_order' do
      @order_1.cancel_order
      @order_1.reload

      expect(@oi_1.quantity).to eq(0)
      expect(@oi_2.quantity).to eq(0)
      expect(@order_1.status).to eq('cancelled')
    end

    it '.items_packaged' do
      @order_2.items_packaged

      expect(@order_2.status).to eq('packaged')
    end

    it '.fulfill_order' do
      @order_2.fulfill_order
      expect(@order_2.status).to eq("pending")
    end

    it '.ship_order' do
      @order_2.ship_order
    expect(@order_2.status).to eq("shipped")
    end

    it '.customer' do

      expect(@order_1.customer).to eq(@user_1)
    end
  end
end
