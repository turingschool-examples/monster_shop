Item.destroy_all
Merchant.destroy_all
Order.destroy_all
OrderItem.destroy_all
Review.destroy_all
User.destroy_all

megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, enabled: true)
brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218, enabled: true)
ogre = megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
giant = megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
hippo = brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
alex = User.create!(name: "Alex Hennel", address: "123 Straw Lane", city: "Straw City", state: "CO", zip: 12345, email: "straw@gmail.com", password: "fish", role: 0)
berry = User.create!(name: "Berry Blue", address: "345 Blue Lane", city: "Blue City", state: "CA", zip: 56789, email: "blue@gmail.com", password: "bear", role: 1, merchant_id: megan.id)
larry = User.create!(name: "Larry Green", address: "345 Blue Lane", city: "Blue City", state: "CA", zip: 56789, email: "green@gmail.com", password: "frogs", role: 2, merchant_id: brian.id)
jeff = User.create!(name: "Jeff Casimir", address: "345 Blue Lane", city: "Blue City", state: "CA", zip: 56789, email: "jeff@gmail.com", password: "jeff", role: 3)
order_1 = alex.orders.create!
order_2 = berry.orders.create!
order_1.order_items.create!(item: ogre, price: ogre.price, quantity: 2, status: 'fulfilled')
order_1.order_items.create!(item: hippo, price: hippo.price, quantity: 3, status: 'unfulfilled')
order_2.order_items.create!(item: hippo, price: hippo.price, quantity: 2, status: 'fulfilled')
order_2.order_items.create!(item: hippo, price: hippo.price, quantity: 2, status: 'fulfilled')
order_2.update(status: "packaged")
