class Admin::DashboardController < Admin::BaseController

  def show
    @orders = Order.all.sort_by_status
  end

  def ship_order
    @order = Order.find([:id])
    if @order.packaged?
      @order.status == "shipped"
    end 
  end
end
