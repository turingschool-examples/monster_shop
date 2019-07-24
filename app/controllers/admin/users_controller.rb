class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:enable, :disable]
  def index
    @users = User.where.not(role: "admin")
  end

  def show
    @user = User.find(params[:id])
  end

  def enable
    @user.update(enabled: true)
    flash[:notice] = "The account for #{@user.name} is now enabled."
    redirect_to admin_user_index_path
  end

  def disable
    @user.update(enabled: false)
    flash[:notice] = "The account for #{@user.name} is now disabled."
    redirect_to admin_user_index_path
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
