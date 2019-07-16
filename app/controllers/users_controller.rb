class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def show
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

  def edit
  end

  def update
    # binding.pry
    @user = User.find(params[:id])
    if !@user.update(user_params)
      flash[:error] = @user.errors.full_messages.join(". ")
    else
      @user.update(user_params)
      flash[:notice] = "Your profile has been updated!"
    end
    redirect_to "/users/#{@user.id}"
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password)
  end

  def set_user
    @user = User.find(session[:user_id]) if session[:user_id]
    @user = User.find(params[:id]) if @user.nil?
  end
end
