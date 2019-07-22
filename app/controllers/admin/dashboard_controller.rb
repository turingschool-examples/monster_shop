class Admin::DashboardController < Admin::BaseController
  def show
    @orders = Order.all
    @orders = @orders.sort_by_status
  end
end
