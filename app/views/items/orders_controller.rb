class MerchantAdmins::OrdersController < MerchantAdmins::BaseController

  def show
    @merchant = Merchant.find(current_user.merchant_id)
    @items = @merchant.order_items
    @order = Order.find(params[:id])
    @customer = @order.customer
  end

  def update
    @order = Order.find(params[:id])
    # @order.subtract_inventory
    @order.fulfill_order
    # @order.order_items.subtract_inventory
    flash[:message] = "You have fuilfilled the order"
    redirect_to merchant_admins_order_path(@order.id)
    end
	end
