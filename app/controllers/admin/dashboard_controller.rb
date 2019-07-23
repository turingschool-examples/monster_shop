class Admin::DashboardController < Admin::BaseController
  def ship_order
    @order = Order.find([:id])
    if @order.packaged?
      @order.status == "shipped"
    end
  end
end
