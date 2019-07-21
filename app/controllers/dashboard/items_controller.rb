class Dashboard::ItemsController < Merchant::BaseController
  def index
    @merchant = User.find(current_user.id)
    @items = Item.all
    # @items = @merchant.items
  end

  def deactivate
    item = Item.find(params[:item_id])
    item.active == false
    item.update(active: false)
    flash[:message] = "#{item.name} is no longer avalible for sale."
    redirect_to dashboard_items_path
  end
end
