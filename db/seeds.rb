Item.destroy_all
Merchant.destroy_all
Order.destroy_all
OrderItem.destroy_all
Review.destroy_all
User.destroy_all

merchant1 = Merchant.create!(name: 'Kaiju', address: '1531 Madison Ave', city: 'New York', state: 'NY', zip: '10005',  image: 'https://cdn.shopify.com/s/files/1/0584/3841/products/vinyl-kaiju-dunny-battle-3-mini-figure-series-by-kidrobot-x-clutter-18_1200x.gif?v=1550786302')
merchant2 = Merchant.create!(name: 'Donk', address: '321 Rodeo', city: 'Beverly Hills', state: 'CA', zip: '90210', image: 'https://cdn.shopify.com/s/files/1/0584/3841/products/vinyl-kaiju-dunny-battle-3-mini-figure-series-by-kidrobot-x-clutter-17_1200x.gif?v=1550786302')
merchant3 = Merchant.create!(name: 'Julius', address: '1156 Berry Loop', city: 'Austin', state: 'TX', zip:'73301', image: 'https://cdn.shopify.com/s/files/1/0584/3841/products/vinyl-kidrobot-x-dcon-designer-con-dunny-art-figure-series-19_1200x.jpg?v=1550786306')
merchant4 = Merchant.create!(name: 'Campbell', address: '312 Sailers Way', city: 'Seattle', state: 'WA', zip: '98101',  image: 'https://cdn.shopify.com/s/files/1/0584/3841/products/vinyl-andy-warhol-3-dunny-blind-box-mini-series-2-4_1200x.jpg?v=1539657166')
merchant5 = Merchant.create!(name: 'Batman', address: '546 West Grady Street', city: 'Boston', state: 'MA', zip: '02101', image:'https://cdn.shopify.com/s/files/1/0584/3841/products/vinyl-classic-batman-5-dunny-1_1200x.jpg?v=1540353950')
merchant6 = Merchant.create!(name: 'Fini', address: '1974 Peachtree Way', city: 'Atlanta', state: 'GA', zip: '30305', image: 'https://cdn.shopify.com/s/files/1/0584/3841/products/vinyl-good-4-nothing-8-dunny-art-figure-by-64-colors-1_1200x.jpg?v=1558495540')


benny = merchant1.items.create!(name: 'Apocalypse Benny', description: 'Tough construction worker', price: 2.29, active: true, inventory: 10, image: 'https://www.lego.com/r/www/r/catalogs/-/media/catalogs/characters/minifigures/2019/71023-11.jpg?l.r=1927415428')
candy = merchant2.items.create!(name: 'Candy Rapper', description: 'The Queen Bee', price: 2.75, active: true, inventory: 25, image: 'https://www.lego.com/r/www/r/catalogs/-/media/catalogs/characters/minifigures/2019/71023-19.jpg?l.r=634548314')
hula = merchant3.items.create!(name: 'Hula Lula', description: 'Collectible figurine', price: 3.15, active: true, inventory: 12, image: 'https://www.lego.com/r/www/r/catalogs/-/media/catalogs/characters/minifigures/2019/71023-24.jpg?l.r=-1337733660')
melon = merchant4.items.create!(name: 'Water Melon Dude', description: 'Rare', price: 5.35, active: true, inventory: 5, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71023-07?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fminifigures%2f2019%2f71023-07.jpg%3fl.r%3d-760753925')
swamp = merchant5.items.create!(name: 'The Swamp Creature', description: 'Figurine based on The Shape of Water', price: 2.29, active: true, inventory: 9, image: 'https://www.lego.com/r/www/r/catalogs/-/media/catalogs/characters/minifigures/2019/71023-22.jpg?l.r=-1662466849')
pop = merchant6.items.create!(name: 'Kitty Pop', description: 'World famous singing kitten', price: 2.25, active: true, inventory: 13, image: 'https://www.lego.com/r/www/r/catalogs/-/media/catalogs/characters/minifigures/2019/71023-20.jpg?l.r=1899013232')
battle = merchant1.items.create!(name: 'Battle Ready Lucy', description: 'The real deal', price: 2.99, active: true, inventory: 13, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71023-02?width=744&ratio=1&imageUrl=https%3A%2F%2Fwww.lego.com%2Fr%2Fwww%2Fr%2Fcatalogs%2F-%2Fmedia%2Fcatalogs%2Fcharacters%2Fminifigures%2F2019%2F71023-02.jpg%3Fl.r%3D340680808')
emmet = merchant2.items.create!(name: 'Remix Emmet', description: 'All Star DJ', price: 3.15, active: true, inventory: 3, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71023-01?width=744&ratio=1&imageUrl=https%3A%2F%2Fwww.lego.com%2Fr%2Fwww%2Fr%2Fcatalogs%2F-%2Fmedia%2Fcatalogs%2Fcharacters%2Fminifigures%2F2019%2F71023-01.jpg%3Fl.r%3D-785580292')
lion = merchant3.items.create!(name: 'Cowardly Lion', description: 'Perfect for the Oz fan', price: 8.19, active: true, inventory: 7, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71023-14?width=744&ratio=1&imageUrl=https%3A%2F%2Fwww.lego.com%2Fr%2Fwww%2Fr%2Fcatalogs%2F-%2Fmedia%2Fcatalogs%2Fcharacters%2Fminifigures%2F2019%2F71023-14.jpg%3Fl.r%3D-23236892')
gale = merchant4.items.create!(name: 'Dorothy Gale', description: 'Remarkable resemblance', price: 2.95, active: true, inventory: 15, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71023-13?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fminifigures%2f2019%2f71023-13.jpg%3fl.r%3d216812750')
golfin = merchant5.items.create!(name: 'Gone Golfin', description: 'Pro Golfer on PGA tour', price: 6.75, active: true, inventory: 18, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71023-17?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fminifigures%2f2019%2f71023-17.jpg%3fl.r%3d1175492564')
lucy = merchant6.items.create!(name: 'Flashback Lucy', description: 'Gold Record in hand', price: 2.15, active: true, inventory: 11, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71023-18?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fminifigures%2f2019%2f71023-18.jpg%3fl.r%3d1171830203')
rex = merchant1.items.create!(name: 'Vest Friend Rex', description: 'Fashion forward cowboy', price: 5.18, active: true, inventory: 20, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71023-12?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fminifigures%2f2019%2f71023-12.jpg%3fl.r%3d-1403796392')
tin = merchant2.items.create!(name: 'Tin Man', description: 'Heart included', price: 11.45, active: true, inventory: 13, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71023-15?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fminifigures%2f2019%2f71023-15.jpg%3fl.r%3d-1810901973')
crayon = merchant3.items.create!(name: 'Crayon Girl', description: 'Purple and fabulous', price: 2.05, active: true, inventory: 3, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71023-04?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fminifigures%2f2019%2f71023-04.jpg%3fl.r%3d-579867002')
abe = merchant4.items.create!(name: 'Apocalypseburg Abe', description: 'Honest and brave', price: 5.85, active: true, inventory: 27, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71023-21?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fminifigures%2f2019%2f71023-21.jpg%3fl.r%3d-128871223')
giraffe = merchant5.items.create!(name: 'Giraffe Guy', description: 'Escaped from the zoo', price: 1.49, active: true, inventory: 5, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71023-05?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fminifigures%2f2019%2f71023-05.jpg%3fl.r%3d-2085519459')
kitty = merchant6.items.create!(name: 'Uni-Kitty', description: 'Straight from Japan', price: 2.21, active: true, inventory: 14, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71023-23?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fminifigures%2f2019%2f71023-23.jpg%3fl.r%3d440592944')
groot = merchant1.items.create!(name: 'Groot', description: 'Favorite of many', price: 4.85, active: true, inventory: 4, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fmarvel%2f2018%2f2hy%2fcharacters%2f76102_groot.png%3fl.r%3d1712906388')
anakin = merchant2.items.create!(name: 'Anakin Skywalker', description: 'Fierce and light sabre ready', price: 6.20, active: true, inventory: 17, image: 'https://www.lego.com/r/www/r/catalogs/-/media/catalogs/characters/star%20wars/star%20wars%202018/august/overviewanakinskywalker.png?l.r=1675939523')
superman = merchant3.items.create!(name: 'Superman', description: 'A natural classic', price: 1.25, active: true, inventory: 6, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fdc%2f2018%2f76096_superman.png%3fl.r%3d93518455')
quinn = merchant4.items.create!(name: 'Harley Quinn', description: 'Deceptive in a good way', price: 2.75, active: true, inventory: 14, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fdc%2f2018%2f70922_harley_quinn.png%3fl.r%3d726252330')
luke = merchant5.items.create!(name: 'Luke Skywalker', description: 'No description needed', price: 2.55, active: true, inventory: 24, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fstar%2520wars%2fstar%2520wars%25202018%2faugust%2foverviewlukeskywalker.png%3fl.r%3d-425725516')
sherry = merchant6.items.create!(name: 'Sherry Scratchen', description: 'Cat lady galore', price: 3.68, active: true, inventory: 19, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71023-10?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fminifigures%2f2019%2f71023-10.jpg%3fl.r%3d-192025609')
america = merchant1.items.create!(name: 'Captain America', description: 'Superior Patriot', price: 4.11,  active: true, inventory: 13, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/?width=3200&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fportals%2f-%2fmedia%2fthemes%2fmarvel-superheroes%2fgrown-up%2fcharacters%2fcaptainamerica.png%3fl.r%3d-892047551')
joker = merchant2.items.create!(name: 'The Joker', description: 'Scary and captivating', price: 3.15, active: true, inventory: 14, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fdc%2f2018%2f70922_joker.png%3fl.r%3d1997999619')
wonder = merchant3.items.create!(name: 'Wonder Woman', description: "Nostalgia at it's best", price: 6.89 , active: true, inventory: 7, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fdc%2f2018%2f76097_wonder_woman.png%3fl.r%3d1018924003')
robin = merchant4.items.create!(name: 'Robin', description: 'Reliable sidekick', price: 4.22, active: true, inventory: 2, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fdc%2f2018%2frobin.png%3fl.r%3d-867137417')
cheetah = merchant5.items.create!(name: 'Cheetah', description: 'Not quite human', price: 3.27, active: true, inventory: 3, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fdc%2f2018%2f76097_cheetah.png%3fl.r%3d-218766292')
fire = merchant6.items.create!(name: 'Firestorm', description: 'Can take the heat', price: 4.99, active: true, inventory: 1, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fdc%2f2018%2f76097_firestorm.png%3fl.r%3d570036710')
batty = merchant1.items.create!(name: 'Batman', description: 'Kept in the dark', price:7.66 , active: true, inventory: 8, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fdc%2f2018%2f76117_batman.png%3fl.r%3d1390635591')
barbara = merchant2.items.create!(name: 'Barbara Gordon', description: 'Serves the people', price: 1.67, active: true, inventory: 22, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fdc%2f2018%2f70922_barbara_gordon.png%3fl.r%3d1480415558')
panther = merchant2.items.create!(name: 'Black Panther', description: 'Box office crusher', price: 8.50, active: true, inventory: 6, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fmarvel%2f2018%2f2hy%2fcharacters%2fblackpanther.png%3fl.r%3d-14195683')
rocket = merchant3.items.create!(name: 'Rocket', description: 'Not house trained', price: 4.33 , active: true, inventory: 6, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fmarvel%2f2018%2f2hy%2fcharacters%2f76102_rocket.png%3fl.r%3d-1308534922')
gamora = merchant4.items.create!(name: 'Gamora', description: 'High maintenance', price: 9.99 , active: true, inventory: 12, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fmarvel%2f2018%2f2hy%2fcharacters%2fgamora.png%3fl.r%3d-1091982522')
shuri = merchant5.items.create!(name: 'Shuri', description: 'Will not back down', price: 4.77, active: true, inventory: 2, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fmarvel%2f2018%2f2hy%2fcharacters%2fshuri.png%3fl.r%3d-194147270')
vision = merchant6.items.create!(name: 'Vision', description: 'Do not look into his eyes', price: 3.13, active: true, inventory: 18, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2fcharacters%2fmarvel%2f2018%2f2hy%2fcharacters%2f76103_vision.png%3fl.r%3d699235150')
scarecrow = merchant1.items.create!(name: 'Scarecrow', description: 'Complete your set', price: 8.76 , active: true, inventory: 4, image: 'https://img.brickowl.com/files/image_cache/larger/lego-scarecrow-minifigure-121146-25.jpg')
lobster = merchant2.items.create!(name: 'Lobster Lovin', description: 'Ladies man', price: 2.34 , active: true, inventory: 5, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71017_leaflet_lobster-lovin_batman?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2farticles%2fbatmanmovie%2fblog%2fminifigs%2f71017_leaflet_lobster-lovin_batman.jpg%3fl.r%3d1597955750')
heart = merchant3.items.create!(name: 'Pink Power', description: 'Heart breaker', price: 1.45, active: true, inventory: 3, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71017_leaflet_pink_power_batgirl?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2farticles%2fbatmanmovie%2fblog%2fminifigs%2f71017_leaflet_pink_power_batgirl.jpg%3fl.r%3d-589797275')
eraser = merchant4.items.create!(name: 'The Eraser', description: 'Not afraid to make a mistake', price: 7.11 , active: true, inventory: 11, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71017_leaflet_the_eraser?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2farticles%2fbatmanmovie%2fblog%2fminifigs%2f71017_leaflet_the_eraser.jpg%3fl.r%3d-1031864690')
programmer = merchant5.items.create!(name: 'The Programmer', description: 'Turing Alum', price: 4.58, active: true, inventory: 15, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71017_leaflet_the_mime?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2farticles%2fbatmanmovie%2fblog%2fminifigs%2f71017_leaflet_the_mime.jpg%3fl.r%3d126102964')
commisioner = merchant6.items.create!(name: 'Vacation Batman', description: 'Not always on call', price: 9.22, active: true, inventory: 21, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71017_leaflet_vacation_batman?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2farticles%2fbatmanmovie%2fblog%2fminifigs%2f71017_leaflet_vacation_batman.jpg%3fl.r%3d-856237070')
gordon = merchant1.items.create!(name: 'Commisioner Gordon', description: 'All business', price: 5.25, active: true, inventory: 19, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71017_leaflet_commissioner_gordon?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2farticles%2fbatmanmovie%2fblog%2fminifigs%2f71017_leaflet_commissioner_gordon.jpg%3fl.r%3d-1526602260')
officer = merchant6.items.create!(name: 'Officer Gordon', description: 'Never off duty', price: 8.80, active: true, inventory: 4, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71017_leaflet_barbara_gordon?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2farticles%2fbatmanmovie%2fblog%2fminifigs%2f71017_leaflet_barbara_gordon.jpg%3fl.r%3d255439330')
dick = merchant4.items.create!(name: 'Dick Grayson', description: 'Do not under estimate a man in glasses', price: 7.10 , active: true, inventory: 9 , image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71017_leaflet_dick_grayson?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2farticles%2fbatmanmovie%2fblog%2fminifigs%2f71017_leaflet_dick_grayson.jpg%3fl.r%3d-1112563153')
glam = merchant6.items.create!(name: 'Glam Metal', description: 'Coachella Star', price:6.66 , active: true, inventory: 6, image: 'https://lc-imageresizer-live-s.legocdn.com/resize/71017_leaflet_glam_metal_batman?width=744&ratio=2&imageUrl=https%3a%2f%2fwww.lego.com%2fr%2fwww%2fr%2fcatalogs%2f-%2fmedia%2fcatalogs%2farticles%2fbatmanmovie%2fblog%2fminifigs%2f71017_leaflet_glam_metal_batman.jpg%3fl.r%3d315623033')
hamley = merchant5.items.create!(name: 'Hamley', description: 'The Royal Guard', price: 5.90, active: true, inventory: 34 , image: 'https://www.hamleys.com/images/_lib/1-lego-hamleys-exclusive-royal-guard-minifigure-5005233-111400-0.jpg')


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
order_1.order_items.create!(item: lobster, price: lobster.price, quantity: 2, status: 'fulfilled')
order_1.order_items.create!(item: emmet, price: emmet.price, quantity: 3, status: 'unfulfilled')
order_2.order_items.create!(item: rex, price: rex.price, quantity: 2, status: 'fulfilled')
order_2.order_items.create!(item: hippo, price: hippo.price, quantity: 2, status: 'fulfilled')
order_3 = alex.orders.create!
order_4 = berry.orders.create!
order_4.order_items.create!(item: hamley, price: hamley.price, quantity: 2, status: 'fulfilled')
order_4.order_items.create!(item: hippo, price: hippo.price, quantity: 3, status: 'unfulfilled')
order_3.order_items.create!(item: hippo, price: hippo.price, quantity: 3, status: 'fulfilled')
order_3.order_items.create!(item: eraser, price: eraser.price, quantity: 2, status: 'fulfilled')
order_5 = alex.orders.create!
order_6 = berry.orders.create!
order_5.order_items.create!(item: ogre, price: ogre.price, quantity: 2, status: 'fulfilled')
order_5.order_items.create!(item: eraser, price: eraser.price, quantity: 3, status: 'unfulfilled')
order_6.order_items.create!(item: hippo, price: hippo.price, quantity: 2, status: 'fulfilled')
order_7 = alex.orders.create!
order_8 = berry.orders.create!
order_7.order_items.create!(item: ogre, price: ogre.price, quantity: 2, status: 'fulfilled')
order_7.order_items.create!(item: hippo, price: hippo.price, quantity: 3, status: 'unfulfilled')
order_8.order_items.create!(item: hippo, price: hippo.price, quantity: 2, status: 'fulfilled')
order_8.order_items.create!(item: hippo, price: hippo.price, quantity: 2, status: 'fulfilled')
order_9 = alex.orders.create!
order_10 = berry.orders.create!
order_10.order_items.create!(item: ogre, price: ogre.price, quantity: 2, status: 'fulfilled')
order_10.order_items.create!(item: sherry, price: sherry.price, quantity: 3, status: 'unfulfilled')
order_9.order_items.create!(item: wonder, price: wonder.price, quantity: 2, status: 'fulfilled')
order_9.order_items.create!(item: hippo, price: hippo.price, quantity: 2, status: 'fulfilled')
order_11 = alex.orders.create!
order_12 = berry.orders.create!
order_11.order_items.create!(item: sherry, price: sherry.price, quantity: 2, status: 'fulfilled')
order_11.order_items.create!(item: joker, price: joker.price, quantity: 3, status: 'unfulfilled')
order_12.order_items.create!(item: kitty, price: kitty.price, quantity: 2, status: 'fulfilled')
order_12.order_items.create!(item:quinn, price:quinn.price, quantity: 2, status: 'fulfilled')
order_13 = alex.orders.create!
order_14 = berry.orders.create!
order_13.order_items.create!(item: hula, price: hula.price, quantity: 2, status: 'fulfilled')
order_14.order_items.create!(item: quinn, price: quinn.price, quantity: 3, status: 'unfulfilled')
order_14.order_items.create!(item: dick, price: dick.price, quantity: 2, status: 'fulfilled')
order_13.order_items.create!(item: america, price: america.price, quantity: 2, status: 'fulfilled')
order_15 = alex.orders.create!
order_16 = berry.orders.create!
order_16.order_items.create!(item: melon, price: melon.price, quantity: 2, status: 'fulfilled')
order_15.order_items.create!(item: lucy, price: lucy.price, quantity: 3, status: 'unfulfilled')
order_16.order_items.create!(item: lucy, price: lucy.price, quantity: 2, status: 'fulfilled')
order_15.order_items.create!(item: candy, price: candy.price, quantity: 2, status: 'fulfilled')
order_17 = alex.orders.create!
order_18 = berry.orders.create!
order_17.order_items.create!(item: programmer, price: programmer.price, quantity: 2, status: 'fulfilled')
order_17.order_items.create!(item: lion, price: lion.price, quantity: 3, status: 'unfulfilled')
order_18.order_items.create!(item: america, price: america.price, quantity: 2, status: 'fulfilled')
order_18.order_items.create!(item: hippo, price: hippo.price, quantity: 2, status: 'fulfilled')
order_19 = alex.orders.create!
order_20 = berry.orders.create!
order_19.order_items.create!(item: superman, price: superman.price, quantity: 2, status: 'fulfilled')
order_19.order_items.create!(item: lobster, price: lobster.price, quantity: 3, status: 'unfulfilled')
order_20.order_items.create!(item: abe, price: abe.price, quantity: 2, status: 'fulfilled')
order_20.order_items.create!(item: hippo, price: hippo.price, quantity: 2, status: 'fulfilled')
order_21 = alex.orders.create!
order_22 = berry.orders.create!
order_21.order_items.create!(item: kitty, price: kitty.price, quantity: 2, status: 'fulfilled')
order_21.order_items.create!(item: groot, price: groot.price, quantity: 3, status: 'unfulfilled')
order_22.order_items.create!(item: groot, price: groot.price, quantity: 2, status: 'fulfilled')
order_22.order_items.create!(item: wonder, price: wonder.price, quantity: 2, status: 'fulfilled')
order_23 = alex.orders.create!
order_24 = berry.orders.create!
order_23.order_items.create!(item: kitty, price: kitty.price, quantity: 2, status: 'fulfilled')
order_24.order_items.create!(item: anakin, price: anakin.price, quantity: 3, status: 'unfulfilled')
order_23.order_items.create!(item: superman, price: superman.price, quantity: 2, status: 'fulfilled')
order_24.order_items.create!(item: hippo, price: hippo.price, quantity: 2, status: 'fulfilled')
order_25 = alex.orders.create!
order_26 = berry.orders.create!
order_26.order_items.create!(item: groot, price: groot.price, quantity: 2, status: 'fulfilled')
order_26.order_items.create!(item: superman, price: superman.price, quantity: 3, status: 'unfulfilled')
order_25.order_items.create!(item: superman, price: superman.price, quantity: 2, status: 'fulfilled')
order_25.order_items.create!(item: pop, price: pop.price, quantity: 2, status: 'fulfilled')
order_27 = alex.orders.create!
order_28 = berry.orders.create!
order_27.order_items.create!(item: gordon, price: gordon.price, quantity: 2, status: 'fulfilled')
order_27.order_items.create!(item: melon, price: melon.price, quantity: 3, status: 'unfulfilled')
order_28.order_items.create!(item: pop, price: pop.price, quantity: 2, status: 'fulfilled')
order_28.order_items.create!(item: candy, price: candy.price, quantity: 2, status: 'fulfilled')



order_2.update(status: "packaged")
