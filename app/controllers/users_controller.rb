class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def new
    @user = User.new
    unless @user
      render file: '/public/404', status: 404, layout: false
    end
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
    @user = current_user
    unless current_user? || current_merchant?
      render file: '/public/404', status: 404, layout: false
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      session[:user_id] = @user.id
      flash[:notice] = "Your profile has been updated!"
      redirect_to profile_path
    else
      generate_flash(@user)
      render :edit
    end
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password)
  end

  def set_user
    @user = current_user
  end
end
