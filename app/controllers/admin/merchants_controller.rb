class Admin::MerchantsController < Admin::BaseController
  before_action :set_merchant, only: [:show, :destroy, :enable, :disable]

  def index
    @merchants = Merchant.all
  end

  def show
    @orders = @merchant.pending_orders
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      redirect_to '/merchants'
    else
      generate_flash(@merchant)
      render :new
    end
  end

  def destroy
    if @merchant.order_items.empty?
      @merchant.destroy
    else
      flash[:notice] = "#{@merchant.name} can not be deleted - they have orders!"
    end
    redirect_to '/merchants'
  end

  def enable
    @merchant.items_active
    @merchant.update(enabled: true)
    flash[:notice] = "The account for #{@merchant.name} is now enabled."
    redirect_to admin_merchant_index_path
  end

  def disable
    @merchant.items_inactive
    @merchant.update(enabled: false)
    flash[:notice] = "The account for #{@merchant.name} is now disabled."
    redirect_to admin_merchant_index_path
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name, :address, :city, :state, :zip)
  end

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end
end
