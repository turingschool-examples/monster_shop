User.destroy_all
Merchant.destroy_all
Item.destroy_all
Review.destroy_all
Order.destroy_all
OrderItem.destroy_all

@megan = Merchant.create!(name: 'Megans Monsters', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
@brian = Merchant.create!(name: 'Brians Beasts', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

@ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: '/images/ogre.jpg', active: true, inventory: 5 )
@giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: '/images/giant.jpg', active: true, inventory: 3 )
@mermaid = @megan.items.create!(name: 'Mermaid', description: "I'm a Mermaid!", price: 500, image: '/images/mermaid.jpg', active: true, inventory: 13 )
@dragon = @megan.items.create!(name: 'Dragon', description: "I'm a Dragon", price: 2000, image: '/images/dragon.jpg', active: true, inventory: 3 )
@fairy = @megan.items.create!(name: 'Fairy', description: "I'm a Fairy", price: 25, image: '/images/fairy.jpg', active: true, inventory: 66 )
@hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: '/images/hippo.jpg', active: true, inventory: 3 )
@warewolf = @brian.items.create!(name: 'Warewolf', description: "I'm a Warewolf", price: 600, image: '/images/warewolf.jpg', active: true, inventory: 13 )

@yeti = @brian.items.create!(name: 'Yeti', description: "I'm a Yeti", price: 34, image: '/images/yeti.jpg', active: true, inventory: 34 )
@troll = @brian.items.create!(name: 'Troll', description: "I'm a Troll", price: 55, image: '/images/troll.jpg', active: true, inventory: 20 )

@ghoul = @brian.items.create!(name: 'Ghoul', description: "I'm a Ghoul", price: 99, image: '/images/ghoul.jpg', active: true, inventory: 3 )

@unicorn = @brian.items.create!(name: 'Unicorn', description: "I'm a Unicorn!", price: 50, image: '/images/unicorn.jpg', active: false, inventory: 8 )

@user_1 = User.create!(name: "Santi", user_name: "user_1_email@emailplace.com", password: "test", role: 0, address: "123 Donut St", city: "Denver", state: "CO", zip: 22222)

@user_2 = User.create!(name: "Will", user_name: "will@emailplace.com", password: "test", role: 0, address: "123 Donut St", city: "Denver", state: "CO", zip: 22222)

@user_3 = User.create!(name: "Jori", user_name: "jori@emailplace.com", password: "test", role: 0, address: "123 Donut St", city: "Denver", state: "CO", zip: 22222)

@order_1 = @user_1.orders.create!
@order_2 = @user_1.orders.create!
@order_3 = @user_1.orders.create!
@order_4 = @user_1.orders.create!
@order_5 = @user_2.orders.create!
@order_6 = @user_3.orders.create!

@order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
@order_1.order_items.create!(item: @giant, price: @ogre.price, quantity: 2)
@order_2.order_items.create!(item: @mermaid, price: @ogre.price, quantity: 2)
@order_2.order_items.create!(item: @hippo, price: @hippo.price, quantity: 3)

@order_3.order_items.create!(item: @dragon, price: @dragon.price, quantity: 2)
@order_3.order_items.create!(item: @fairy, price: @fairy.price, quantity: 2)

@order_4.order_items.create!(item: @dragon, price: @dragon.price, quantity: 3)
@order_4.order_items.create!(item: @troll, price: @troll.price, quantity: 3)
@order_5.order_items.create!(item: @yeti, price: @yeti.price, quantity: 3)
@order_5.order_items.create!(item: @unicorn, price: @unicorn.price, quantity: 3)




@jori = User.create!(user_name: "jpeterson", password: "123", password_confirmation: "123", role: 0, name: "Jori Peterson", address: "123 Main St", city: "Westminster", state: "Colorado", zip: 80791)
@nathan = User.create!(user_name: "nthomas", password: "123", password_confirmation: "123", role: 0, name: "Nathan Thomas", address: "123 Main St", city: "Gunbarrel", state: "Colorado", zip: 80301, merchant_id: @megan.id)
@andrew = User.create!(user_name: "ajohnson", password: "123", password_confirmation: "123", role: 1, name: "Andrew Johnson", address: "123 Main St", city: "Lakewood", state: "Colorado", zip: 80401, merchant_id: @megan.id)
@will = User.create!(user_name: "wthomson", password: "123", password_confirmation: "123", name: "Will Thompson", address: "123 Main St", city: "Longmont", state: "Colorado", zip: 80501)
@admin123 = User.create!(user_name: "andrew@gmail.com", password: "thinking123", role: 2, name: "Andrew", address: "333 Market St", city: "Denver", state: "CO", zip: 80012 )
