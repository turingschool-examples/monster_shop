require 'rails_helper'

RSpec.describe 'Admin' do
  describe 'when I visit my dashboard' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @admin = User.create!(name: "Admin", address: "123 Cheese Lane", city: "Cheese City", state: "CO", zip: 12345, email: "admin@gmail.com", password: "rabbit", role: 3)
      @reg_user = User.create!(name: "Alex Hennel", address: "123 Straw Lane", city: "Straw City", state: "CO", zip: 12345, email: "straw@gmail.com", password: "fish", role: 0)
      @employee = User.create!(name: "Tyler", address: "123 Bean Lane", city: "Bean City", state: "CO", zip: 12345, email: "employee@gmail.com", password: "soup", role: 1, merchant_id: @megan.id)
      @order_1 = @reg_user.orders.create
      @order_1.order_items.create!(item_id: @giant.id, price: @giant.price, quantity: 2)
      @order_1.order_items.create!(item_id: @hippo.id, price: @hippo.price, quantity: 1)
      @order_2 = @employee.orders.create
      @order_2.order_items.create!(item_id: @ogre.id, price: @ogre.price, quantity: 2)
      @order_2.order_items.create!(item_id: @hippo.id, price: @hippo.price, quantity: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      @order_2.update(status: "packaged")
      @order_2.reload
      visit admin_dashboard_path
    end

    it "each order ID is a link to the admin only view of the order" do
      within "#order-#{@order_1.id}" do
        click_on "#{@order_1.id}"
      end

      expect(current_path).to eq(admin_user_order_path(@reg_user.id, @order_1.id))

      within "#order-#{@order_1.id}" do
        expect(page).to have_content(@order_1.created_at)
        expect(page).to have_content(@order_1.updated_at)
        expect(page).to have_content(@order_1.status)
      end

      within "#item-#{@ogre.id}" do
        expect(page).to have_content(@giant.name)
        expect(page).to have_content(@giant.description)
        expect(page).to have_css("img[src*='#{@giant.image}']")
        expect(page).to have_content("Quantity: 2")
        expect(page).to have_content("Price: #{number_to_currency(@giant.price)}")
        expect(page).to have_content("Subtotal: #{number_to_currency(@giant.price * 2)}")
      end

      within "#item-#{@hippo.id}" do
        expect(page).to have_content(@hippo.name)
        expect(page).to have_content(@hippo.description)
        expect(page).to have_css("img[src*='#{@hippo.image}']")
        expect(page).to have_content("Price: #{number_to_currency(@hippo.price)}")
        expect(page).to have_content("Quantity: 1")
        expect(page).to have_content("Subtotal: #{number_to_currency(@hippo.price * 1)}")
      end
    end

  end
end
