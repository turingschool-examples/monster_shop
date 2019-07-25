class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :destroy]

  def index
    @user = current_user
  end

  def show
  end

  def new
  end

  def create
    order = current_user.orders.new
    if order.save
      cart.items.each do |item|
        order.order_items.create(
          item: item,
          quantity: cart.count_of(item.id),
          price: item.price
        )
      end
      session.delete(:cart)
      flash[:success] = "Order ##{order.id} has been created"
      redirect_to profile_orders_path
    end
  end

  def destroy
    if @order.packaged? || @order.pending?
      @order.update(status: 'canceled')
      @order.cancel_items
      flash[:success] = "Order has been canceled."
      redirect_to profile_path
    else
      flash[:alert] = "This order cannot be canceled!"
      redirect_to profile_path
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
