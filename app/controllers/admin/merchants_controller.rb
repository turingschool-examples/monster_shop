class Admin::MerchantsController < Admin::BaseController

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def enable
    merchant = Merchant.find(params[:id])
    merchant.update(enabled: true)

    redirect_to admin_merchant_show_path(merchant)
  end

  def disable
    merchant = Merchant.find(params[:id])
    merchant.update(enabled: false)
    flash[:notice] = "The account for #{merchant.name} is now disabled"

    redirect_to admin_merchant_index_path
  end

end
