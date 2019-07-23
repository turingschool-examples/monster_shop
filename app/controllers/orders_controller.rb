# frozen_string_literal: true

class OrdersController < ApplicationController

  def index
    @user = current_user
  end

  def show
    @order = Order.find(params[:id])
  end

  def new; end

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
      flash[:notice] = "Order ##{order.id} has been created"
      redirect_to profile_orders_path
    end
  end

  def destroy
    order = Order.find(params[:id])
    if order.packaged? || order.pending?
      order.update(status: 'canceled')
      order.cancel_items
      flash[:notice] = "Order has been canceled."
      redirect_to profile_path
    else
      flash[:notice] = "This order cannot be canceled!"
      redirect_to 
    end
  end
end
