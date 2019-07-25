require 'rails_helper'

RSpec.describe Order do
  describe 'relationships' do
    it {should have_many :order_items}
    it {should have_many(:items).through(:order_items)}
    it {should validate_presence_of :status}
  end

  describe 'instance methods' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @meg = User.create!(name: 'Megan M', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'meg@gmail.com', password: 'fish' )
      @meg2 = User.create!(name: 'Megan M', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'meg2@gmail.com', password: 'fish' )
      @order_1 = @meg.orders.create!
      @order_2 = @meg2.orders.create!

      @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2, status: 'fulfilled')
      @order_1.order_items.create!(item: @hippo, price: @hippo.price, quantity: 3, status: 'unfulfilled')
      @order_2.order_items.create!(item: @hippo, price: @hippo.price, quantity: 2, status: 'fulfilled')
    end

    it '.grand_total' do
      expect(@order_1.grand_total).to eq(190.5)
      expect(@order_2.grand_total).to eq(100)
    end

    it '.subtotal' do
      expect(@order_1.subtotal(@ogre.id)).to eq(40.5)
    end

    it '.count_of' do
      expect(@order_1.count_of(@ogre.id)).to eq(2)
    end

    it '.num_items' do
      expect(@order_1.num_items).to eq(5)
      expect(@order_2.num_items).to eq(2)
    end

    it '.cancel_items' do
      expect(@ogre.inventory).to eq(5)
      expect(@hippo.inventory).to eq(3)
      @order_1.cancel_items
      expect(@ogre.reload.inventory).to eq(7)
      expect(@hippo.reload.inventory).to eq(3)
    end

    it '.get_my_items' do
      meg3 = User.create!(name: 'Megan M', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'meg3@gmail.com', password: 'fish', merchant_id: @megan.id, role: 1)
      expect(@order_1.get_my_items(meg3).first).to eq(@ogre)
    end

    it '.sort_by_status' do
      @order_2.update(status: "packaged")
      @orders = Order.all
      expect(@orders.first.id).to eq(@order_1.id)
      @orders = @orders.sort_by_status
      expect(@orders.first.id).to eq(@order_2.id)
    end

    it '.fulfilled?' do
      expect(@order_1.fulfilled?).to eq(false)
      @order_1.order_items.last.update(status: 'fulfilled')
      expect(@order_1.fulfilled?).to eq(true)
    end

    it '.pending?' do
      @order_2.update(status: 'packaged')
      expect(@order_2.pending?).to eq(false)
      @order_2.update(status: 'pending')
      expect(@order_2.reload.pending?).to eq(true)
    end

    it '.packaged?' do
      @order_1.update(status: 'pending')
      expect(@order_1.packaged?).to eq(false)
      @order_1.update(status: 'packaged')
      expect(@order_1.reload.packaged?).to eq(true)
    end
  end
end
