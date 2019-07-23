class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if @merchant.update(merchant_params)
      redirect_to "/merchants/#{@merchant.id}"
    else
      generate_flash(@merchant)
      render :edit
    end
  end

  private

  def merchant_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
