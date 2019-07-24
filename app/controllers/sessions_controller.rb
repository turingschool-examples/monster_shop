class SessionsController < ApplicationController
  def new
    if current_user
      flash[:message] = 'You are already logged in.'
      redirect_selector
    end
  end

  def create
    if User.exists?(email: params[:email])
      user = User.find_by(email: params[:email])
      if user.enabled
        if user&.authenticate(params[:password])
          session[:user_id] = user.id
          redirect_selector
          flash[:success] = 'You have logged in.'
        else
          flash[:error] = 'Username and password do not match.'
          redirect_to login_path
        end
      else
        flash[:error] = 'You cannot log in because your account has been disabled.'
        redirect_to login_path
      end
    else
      flash[:error] = 'Username and password do not match.'
      redirect_to login_path
    end
  end

  def destroy
    session.delete(:user_id)
    session.delete(:cart)
    flash[:notice] = "You have logged out."
    redirect_to root_path
  end

  private

  def redirect_selector
    redirect_to profile_path if current_user?
    redirect_to merchant_dashboard_path if current_merchant? || current_employee?
    redirect_to admin_dashboard_path if current_admin?
  end
end
