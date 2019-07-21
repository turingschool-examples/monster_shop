class Merchant::DashboardController < Merchant::BaseController
  def show
    @user = current_user
    @merchant = Merchant.find(@user.merchant_id)
    @orders = @merchant.pending_orders
  end
end
