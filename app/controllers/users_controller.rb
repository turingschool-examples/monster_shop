# frozen_string_literal: true

class UsersController < ApplicationController
  # before_action :set_user, only: [:show]

  def new
    @user = User.new
    render file: '/public/404', status: 404 unless @user
  end

  def show
    @user = current_user
    render file: '/public/404', status: 404 unless current_user?
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

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password)
  end
end

# def set_user
#   @user = User.find(session[:user_id])
# end
