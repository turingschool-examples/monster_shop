class Admin::DashboardController < Admin::BaseController

  def show
    @orders = Order.all.sort_by_status
  end
end
