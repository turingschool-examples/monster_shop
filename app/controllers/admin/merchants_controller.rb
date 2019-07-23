class Admin::MerchantsController < Admin::BaseController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
    @orders = @merchant.pending_orders
  end

  def new
    @merchant = Merchant.new
  end

  def create
    merchant = Merchant.new(merchant_params)
    if merchant.save
      redirect_to '/merchants'
    else
      generate_flash(merchant)
      render :new
    end
  end

  def destroy
    merchant = Merchant.find(params[:id])
    if merchant.order_items.empty?
      merchant.destroy
    else
      flash[:notice] = "#{merchant.name} can not be deleted - they have orders!"
    end
    redirect_to '/merchants'
  end

  def enable
    merchant = Merchant.find(params[:id])
    merchant.items_active
    merchant.update(enabled: true)
    flash[:notice] = "The account for #{merchant.name} is now enabled."
    redirect_to admin_merchant_index_path
  end

  def disable
    merchant = Merchant.find(params[:id])
    merchant.items_inactive
    merchant.update(enabled: false)
    flash[:notice] = "The account for #{merchant.name} is now disabled."
    redirect_to admin_merchant_index_path
  end

  private

  def merchant_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
