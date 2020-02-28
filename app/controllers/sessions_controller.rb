class SessionsController < ApplicationController

  def new
		if current_user
			redirect_to_home_paths
			flash[:warning] = "You are already logged in."
		end
  end

  def create
    user = User.find_by(user_name: params[:user_name])
    if user && user.authenticate(params[:password])
     session[:user_id] = user.id
		 redirect_to_home_paths
      flash[:success] = "Logged in as #{user.name}"

    else
      flash.now[:danger] = "User name and/or password invalid."
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    session.delete(:cart)
    flash[:info] = "You have been logged out"
    redirect_to root_path
  end

	private

	def redirect_to_home_paths
		if current_user.user? && current_user.merchant_id
			redirect_to merchant_dashboard_path
		elsif current_user.user?
			redirect_to profile_path
		elsif current_user.merchant_admin?
			redirect_to merchant_dashboard_path
		elsif current_user.admin?
			redirect_to admin_dashboard_path
		end
	end

end
