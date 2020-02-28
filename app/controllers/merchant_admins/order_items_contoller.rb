class MerchantAdmins::OrderItemsController < MerchantAdmins::BaseController

    def update
      @merchant = Merchant.find(current_user.merchant_id)
      @order_items  = @merchant.order_items
      @fulfill = @order_items.fulfill_order
      @sub = @order_items.subtract_inventory
      redirect_to merchant_admins_order_path(@order_items.order_id)
  	end
