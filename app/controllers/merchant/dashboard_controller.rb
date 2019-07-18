class Merchant::DashboardController < Merchant::BaseController
  def show
    @user = current_user
    @merchant = Merchant.find(@user.merchant_id)
  end
end
