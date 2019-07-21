class Admin::DashboardController < Admin::BaseController

  def show_merchant
    @user = current_user
    @merchant = Merchant.find(@user.merchant_id)
    @orders = @merchant.pending_orders
  end
end
