class Merchant::ItemsController < Merchant::BaseController
  def fulfill
    item = Item.find(params[:id])
    order_item = item.get_order_item(params[:order_id])
    order_item.update(status: 'fulfilled')
    amt = item.inventory - order_item.quantity
    item.update(inventory: amt)
    flash[:notice] = "#{item.name} has been fulfilled."
    redirect_to merchant_orders_path(Order.find(params[:order_id]))
  end

  def index
    @merchant = Merchant.find(current_user.merchant_id)
    @items = @merchant.items
  end

  def new
    @item = Item.new(params[:merchant_id])
  end

  def destroy
    item = Item.find(params[:id])
    if item.orders.empty?
      item.destroy
    else
      flash[:notice] = "#{item.name} can not be deleted - it has been ordered!"
    end
    redirect_to dashboard_items_path
  end

  def deactivate
    item = Item.find(params[:item_id])
    item.active == false
    item.update(active: false)
    flash[:message] = "#{item.name} is no longer avalible for sale."
    redirect_to dashboard_items_path
  end

  def activate
    item = Item.find(params[:item_id])
    item.active == true
    item.update(active: true)
    flash[:message] = "#{item.name} is now avalible for sale."
    redirect_to dashboard_items_path
  end
end
