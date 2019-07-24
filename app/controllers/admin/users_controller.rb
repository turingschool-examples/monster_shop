class Admin::UsersController < Admin::BaseController
  def index
    @users = User.where.not(role: "admin")
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @merchants = Merchant.all
  end

  def update
    @user = User.find(params[:id])
    unless user_params[:merchant_id].scan(/\D/).empty?
      params[:user][:merchant_id] = Merchant.find_by(name: params[:user][:merchant_id]).id
    end
    if @user.update_attributes(user_params)
      flash[:notice] = "This user has been updated"
      redirect_to admin_user_show_path(@user)
    else
      generate_flash(@user)
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :role, :merchant_id)
  end
end
