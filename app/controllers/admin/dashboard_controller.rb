class Admin::DashboardController < Admin::BaseController

  def show_merchant
    # @user = current_user
    # binding.pry
    @merchant =  Merchant.find(params[:id])
    @orders = @merchant.pending_orders
  end
end
