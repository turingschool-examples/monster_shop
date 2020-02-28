class Admin:: OrdersController < ApplicationController

	def update
		@order = Order.find(params[:id])
	   @order.ship_order
		 redirect_to admin_dashboard_path
	end
end
