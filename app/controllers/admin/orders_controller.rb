class Admin::OrdersController < Admin::BaseController
  def update
    @order = Order.find(params[:id])
    @order.update(status: "shipped")

    redirect_to admin_dashboard_path
  end

  def index
    @orders = Order.all.sort_by_status
  end

  def ship_order
    @order = Order.find([:id])
    if @order.packaged?
      @order.status == "shipped"
    end
  end
end
