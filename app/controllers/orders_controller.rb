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
      redirect_to profile_orders_path
    else
      flash[:notice] = 'Please complete address form to create an order.'
      render :new
    end
  end
end
