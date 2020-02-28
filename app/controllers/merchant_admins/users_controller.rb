class MerchantAdmins::UsersController < MerchantAdmins::BaseController

	def dashboard
		@merchant = Merchant.find(current_user.merchant_id)
		@pending_orders = @merchant.pending_orders
	end
end
