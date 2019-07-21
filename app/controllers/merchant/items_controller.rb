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
end
