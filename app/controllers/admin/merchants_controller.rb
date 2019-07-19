class Admin::MerchantsController < Admin::BaseController

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def enable
    merchant = Merchant.find(params[:id])
    item_status = merchant.items.map do |item|
      item.update(active: true)
    end
    merchant.update(enabled: true)
    flash[:notice] = "The account for #{merchant.name} is now enabled"

    redirect_to admin_merchant_index_path
  end

  def disable
    merchant = Merchant.find(params[:id])
    item_status = merchant.items.map do |item|
      item.update(active: false)
    end
    merchant.update(enabled: false)
    flash[:notice] = "The account for #{merchant.name} is now disabled"

    redirect_to admin_merchant_index_path
  end

end
