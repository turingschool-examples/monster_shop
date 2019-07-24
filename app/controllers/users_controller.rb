class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    if params[:user][:password] != params[:user][:confirm_password]
      flash[:error] = 'Password does not match!'
      @user = User.new
      render :new
    else
      @user = User.new(strong_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = 'You are now registered and logged in.'
        redirect_to profile_path
      else
        generate_flash(@user)
        render :new
      end
    end
  end

  def show
    @user = current_user
    unless current_user? || current_merchant? || current_employee?
      render file: '/public/404', status: 404, layout: false
    end
  end

  def edit
    @password = params[:edit] == "password"
  end

  def update
    if params[:commit] == "Change Password"
      update_password
    else
      update_profile
    end
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password)
  end

  def strong_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password)
  end

  def set_user
    @user = current_user
  end

  def update_password
    if current_user&.authenticate(params[:current_password])
      if params[:password] == params[:confirm_password]
        @user.update_attributes(password: params[:password])
        session[:user_id] = @user.id
        flash[:notice] = "Your password has been updated."
        redirect_to profile_path
      else
        flash[:notice] = "Passwords do not match."
        redirect_to profile_edit_path(:edit => "password")
      end
    else
      flash[:notice] = "Incorrect Current Password."
      redirect_to profile_edit_path(:edit => "password")
    end
  end

  def update_profile
    if @user.update_attributes(user_params)
      session[:user_id] = @user.id
      flash[:notice] = "Your profile has been updated!"
      redirect_to profile_path
    else
      generate_flash(@user)
      render :edit
    end
  end
end
