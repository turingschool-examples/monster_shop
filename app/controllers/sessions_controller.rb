class SessionsController < ApplicationController
  def new
    unless current_user.nil?
      flash[:message] = 'You are already logged in.'
      redirect_to profile_path if current_user?
      redirect_to merchant_dashboard_path if current_merchant? || current_employee?
      redirect_to admin_dashboard_path if current_admin?
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to profile_path if current_user?
      redirect_to merchant_dashboard_path if current_merchant? || current_employee?
      redirect_to admin_dashboard_path if current_admin?
      flash[:success] = 'You have logged in.'
    else
      flash[:error] = 'Username and password do not match.'
      redirect_to login_path
    end
  end

  def destroy
    user = User.find_by(email: session[:email])
    session[:user_id] = nil
    redirect_to root_path
    flash[:notice] = "You have logged out."
    session.delete(:cart)
  end
end
