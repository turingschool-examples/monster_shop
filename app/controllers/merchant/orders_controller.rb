
class Merchant::OrdersController < Merchant::BaseController
  def show
    @order = Order.find(params[:id])
    @order = get_my_orders(current_user)
  end
end
