class Merchant::OrdersController < Merchant::BaseController
  def show
    @order = Order.find(params[:id])
    @items = @order.get_my_items(current_user)
  end
end
