class Admin::OrdersController < Admin::BaseController
  def show
    @order = Order.find(params[:order_id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(status: "shipped")
    redirect_to admin_dashboard_path
  end

  def index
    @orders = Order.sort_by_status
  end

  def destroy
    @order = Order.find(params[:order_id])
    if @order.pending?
      @order.update(status: 'canceled')
      @order.cancel_items
      flash[:success] = "Order has been canceled."
      redirect_to admin_user_order_path(@order)
    end
  end
end
