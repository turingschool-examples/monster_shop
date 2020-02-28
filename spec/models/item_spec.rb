require 'rails_helper'

RSpec.describe Item do
  describe 'Relationships' do
    it {should belong_to :merchant}
    it {should have_many :order_items}
    it {should have_many(:orders).through(:order_items)}
    it {should have_many :reviews}
  end

  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    #it {should validate_presence_of :image}
    it {should validate_presence_of :price}
    it {should validate_presence_of :inventory}
  end

  describe 'Instance Methods' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @review_1 = @ogre.reviews.create(title: 'Great!', description: 'This Ogre is Great!', rating: 5)
      @review_2 = @ogre.reviews.create(title: 'Meh.', description: 'This Ogre is Mediocre', rating: 3)
      @review_3 = @ogre.reviews.create(title: 'EW', description: 'This Ogre is Ew', rating: 1)
      @review_4 = @ogre.reviews.create(title: 'So So', description: 'This Ogre is So so', rating: 2)
      @review_5 = @ogre.reviews.create(title: 'Okay', description: 'This Ogre is Okay', rating: 4)
    end

    it '.sorted_reviews()' do
      expect(@ogre.sorted_reviews(3, :desc)).to eq([@review_1, @review_5, @review_2])
      expect(@ogre.sorted_reviews(3, :asc)).to eq([@review_3, @review_4, @review_2])
      expect(@ogre.sorted_reviews).to eq([@review_3, @review_4, @review_2, @review_5, @review_1])
    end

    it '.average_rating' do
      expect(@ogre.average_rating.round(2)).to eq(3.00)
    end
  end

  describe 'class Methods' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @mermaid = @megan.items.create!(name: 'Mermaid', description: "I'm a Mermaid!", price: 500, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 13 )
      @dragon = @megan.items.create!(name: 'Dragon', description: "I'm a Dragon", price: 2000, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 4 )
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
      @order_1.order_items.create!(item: @dragon, price: @dragon.price, quantity: 4)
      @order_1.order_items.create!(item: @ghoul, price: @ghoul.price, quantity: 2)
      @order_1.order_items.create!(item: @fairy, price: @fairy.price, quantity: 3)

      @order_2.order_items.create!(item: @yeti, price: @yeti.price, quantity: 1)
      @order_2.order_items.create!(item: @warewolf, price: @warewolf.price, quantity: 1)
      @order_2.order_items.create!(item: @mermaid, price: @mermaid.price, quantity: 1)
      @order_2.order_items.create!(item: @hippo, price: @hippo.price, quantity: 1)
      @order_2.order_items.create!(item: @troll, price: @troll.price, quantity: 1)
    end

    it 'returns the top five objects' do

      expect(Item.favorite_items).to eq([@dragon, @fairy, @ghoul, @giant, @ogre])
    end

    it 'returns the 5 least favorite objects' do

      expect(Item.least_favorite_items).to eq([@hippo, @mermaid, @troll, @warewolf, @yeti])
    end

    it '.purchased' do
      expect(@ogre.purchased.length).to eq(10)

    end
  end
end
