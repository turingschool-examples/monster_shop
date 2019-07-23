class Admin::ItemsController < Admin::BaseController
  def index
    if params[:id]
      @merchant = Merchant.find(params[:id])
      @items = @merchant.items
    end
  end
end
