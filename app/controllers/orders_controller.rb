class OrdersController < ApplicationController
	before_action :get_order, only: [:show, :update]

	def index
		@orders = current_user.orders
	end

  def show
  end

  def new
  end

  def create
    @user = current_user
    @order = @user.orders.new(order_params)
    if @order.save
      cart.items.each do |item|
        @order.order_items.create({
          item: item,
          quantity: cart.count_of(item.id),
          price: item.price
          })
      end
      session.delete(:cart)
			flash[:success] = "Your order was created"
      redirect_to "/profile/orders"
    else
      flash[:danger] = "Please complete address form to create an order."
      render :new
    end
  end

	def update
		@order.cancel_order
		flash[:success] = "That order has been cancelled."
		redirect_to profile_path
	end

  private

  def order_params
    params.permit(:status, :user_id)
  end

	def get_order
		@order = Order.find(params[:id])
	end
end
