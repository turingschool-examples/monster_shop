class Admin::MerchantsController < Admin::BaseController

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def enable
    @merchant = Merchant.find(params[:id])
    @merchant.enabled == true
  end

  def disable
    @merchant = Merchant.find(params[:id])
    @merchant.enabled == false
  end

end
