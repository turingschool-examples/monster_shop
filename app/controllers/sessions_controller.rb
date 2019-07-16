class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if current_user.regular_user?
        redirect_to profile_path
      elsif current_user.merchant?
        redirect_to merchant_dashboard_path
      else current_user.admin?
        redirect_to admin_dashboard_path
      end
      flash[:success] = "You have logged in."
    else
      render :new
    end
  end

end
