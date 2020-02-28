class MerchantsController < ApplicationController
	before_action :get_merchant, only: [:show, :edit, :update]

	def index
    @merchants = Merchant.all
  end

  def show
  end

  # def new
  # end
	#
  # def create
  #   merchant = Merchant.new(merchant_params)
  #   if merchant.save
  #     redirect_to '/merchants'
  #   else
  #     generate_flash(merchant)
  #     render :new
  #   end
  # end
	#
  def edit
  end

  # def update
  #   if @merchant.update(merchant_params)
  #     redirect_to "/merchants/#{@merchant.id}"
  #   else
  #     generate_flash(@merchant)
  #     render :edit
  #   end
  # end
	#
  # def destroy
  #   merchant = Merchant.find(params[:id])
  #   if merchant.order_items.empty?
  #     merchant.destroy
  #   else
  #     flash[:warning] = "#{merchant.name} can not be deleted - they have orders!"
  #   end
  #   redirect_to '/merchants'
  # end

  private

  # def merchant_params
  #   params.permit(:name, :address, :city, :state, :zip)
  # end

	def get_merchant
		@merchant = Merchant.find(params[:id])
	end
end
