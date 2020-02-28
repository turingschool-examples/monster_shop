class Admin::MerchantsController < Admin::BaseController

	def dashboard
		@merchant = Merchant.find(params[:id])
		@pending_orders = @merchant.pending_orders
		render "/merchant_admins/users/dashboard"
	end

	def disable
		merchant = Merchant.find(params[:id])
		merchant.disable
		flash[:success] = "#{merchant.name} is now disabled."
		redirect_to merchants_path
	end

	def enable
		merchant = Merchant.find(params[:id])
		merchant.enable
		flash[:success] = "#{merchant.name} is now enabled."
		redirect_to merchants_path
	end
end
