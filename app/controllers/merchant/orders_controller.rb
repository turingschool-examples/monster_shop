class Merchant::OrdersController < Merchant::BaseController
  def show
    @order = Order.find(params[:id])
    @items = @order.get_my_items(current_user)
  end

  def index
    @user = current_user
    @merchant = Merchant.find(@user.merchant_id)
    @orders = @merchant.pending_orders
  end
end
