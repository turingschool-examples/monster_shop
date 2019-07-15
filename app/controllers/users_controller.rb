class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    if params[:password] != params[:confirm_password]
      flash[:error] = 'Password does not match!'
      render :new
    else
      user = User.new(user_params)
      if user.save
        session[:user_id] = user.id
        flash[:success] = 'You are now registered and logged in.'
        redirect_to profile_path
      else
        generate_flash(user)
        render :new
      end
    end
  end

  def show
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password)
  end

  def set_user
    @user = User.find(session[:user_id])
  end
end
