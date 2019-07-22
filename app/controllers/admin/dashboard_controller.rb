class Admin::DashboardController < Admin::BaseController
  def show
    @orders = Order.select(:id, :user_id, :created_at, :status, :'users.name').joins(:user)
  end
end
