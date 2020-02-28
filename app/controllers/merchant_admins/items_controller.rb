class MerchantAdmins::ItemsController < MerchantAdmins::BaseController

	before_action :get_current_merchant, only: [:index, :new, :create, :update]
	before_action :get_item, only: [:edit, :update]


  def index
    @items = @merchant.items
    render "/items/index"
  end

  def activate
    item = Item.find(params[:item_id])

    if item.active == false
       item.update(active: true)
       item.reload
       flash[:success] = "#{item.name} is now for sale."
    else
      item.update(active: false)
      item.reload
      flash[:warning] = "#{item.name} is no longer for sale."
    end
     redirect_to "/merchants/#{params[:merchant_id]}/items"
  end

  def new
		 @item = Item.new
  end

  def create
    @item = @merchant.items.new(item_params)
    @item.image = params[:image]
    # || 'https://encrypted-tbn0.gstatic.comimages?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw'
    if @item.save
			redirect_to merchant_items_path(@merchant)
      flash[:success] = "#{@item.name} has been saved."
    else
      flash[:danger] = @item.errors.full_messages.to_sentence
      render :new
    end
  end

	def edit
  end

	def update
    if @item.update(item_params)
      redirect_to merchant_items_path(@merchant)
			flash[:success] = "#{@item.name} has been updated"
    else
      flash[:danger] = @item.errors.full_messages.to_sentence
      render :edit
    end
	end

	def destroy
		item = Item.find(params[:id])
		if current_merchant_admin?
			if item.orders.empty?
				item.destroy
				flash[:success] = "#{item.name} has been deleted."
			end
				redirect_to "/merchants/#{params[:merchant_id]}/items"
		else
			if
				item.orders.empty?
				item.destroy
			else
				flash[:danger] = "#{item.name} can not be deleted - it has been ordered!"
			end
			redirect_to items_path
		end
	end

  private

  def item_params
    params.permit(:name, :description, :price, :image, :inventory)
  end

	def get_current_merchant
		@merchant = Merchant.find(current_user.merchant_id)
	end

	def get_item
		@item = Item.find(params[:id])
	end
end
