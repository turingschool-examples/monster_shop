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
      @reg_user.orders.last.order_items.create!(item_id: @giant.id, price: @giant.price, quantity: 2)
      @reg_user.orders.last.order_items.create!(item_id: @hippo.id, price: @hippo.price, quantity: 1)
      @order_2 = @employee.orders.create
      @employee.orders.last.order_items.create!(item_id: @ogre.id, price: @ogre.price, quantity: 2)
      @employee.orders.last.order_items.create!(item_id: @hippo.id, price: @hippo.price, quantity: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      Order.last.update(status: "packaged")
      Order.last.reload
    end

    it 'I can see all orders in the system sorted by status' do
      visit admin_dashboard_path

      # Order 2 is coming first because it has a higher status (packaged) than order 1 (pending)
      within "#order-#{@order_2.id}" do
        expect(page).to have_link(@employee.name, href: admin_user_show_path(@employee.id))
        expect(page).to have_content("Order: ##{@order_2.id}")
        expect(page).to have_content("Created: #{@order_2.created_at}")
      end

      within "#order-#{@order_1.id}" do
        expect(page).to have_link(@reg_user.name, href: admin_user_show_path(@reg_user.id))
        expect(page).to have_content("Order: ##{@order_1.id}")
        expect(page).to have_content("Created: #{@order_1.created_at}")
      end

      expect(@order_2.id.to_s).to appear_before @order_1.id.to_s
    end

  end
end
