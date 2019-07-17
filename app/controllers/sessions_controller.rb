class SessionsController < ApplicationController

  def new
    if current_user
      flash[:notice] = 'You are already logged in.'
      case
      when current_admin?
        redirect_to admin_dashboard_path
      when current_merchant?
        redirect_to merchant_dashboard_path
      else
        redirect_to profile_path
      end
    end
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
      flash[:error] = 'Username and password do not match.'
      redirect_to login_path
    end
  end
end
