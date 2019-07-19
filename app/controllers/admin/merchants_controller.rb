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

    redirect_to admin_merchant_index_path(merchant)
  end

  def disable
    merchant = Merchant.find(params[:id])
    merchant.update(enabled: false)

    redirect_to admin_merchant_index_path
  end

end
