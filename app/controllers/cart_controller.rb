class CartController < ApplicationController
  before_action :deny_admin

  def add_item
    item = Item.find(params[:item_id])
    session[:cart] ||= {}
    if cart.limit_reached?(item.id)
      flash[:notice] = "You have all the item's inventory in your cart already!"
    else
      cart.add_item(item.id.to_s)
      session[:cart] = cart.contents
      flash[:success] = "#{item.name} has been added to your cart!"
    end
    redirect_to items_path
  end

  def show
  end

  def empty
    session.delete(:cart)
    redirect_to cart_path
  end

  def remove_item
    session[:cart].delete(params[:item_id])
    redirect_to cart_path
  end

  def update_quantity
    if params[:change] == "more"
      cart.add_item(params[:item_id])
    elsif params[:change] == "less"
      cart.less_item(params[:item_id])
      return remove_item if cart.count_of(params[:item_id]) == 0
    end
    session[:cart] = cart.contents
    redirect_to cart_path
  end

  private

  def deny_admin
    if current_admin?
      render file: '/public/404', status: 404, layout: false
    end
  end
end
