class Admin::DashboardController < Admin::BaseController

  def show_merchant
    redirect_to merchant_dashboard_path 
  end
end
