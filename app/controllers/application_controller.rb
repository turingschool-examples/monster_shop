# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :cart,
                :current_user,
                :current_user?,
                :current_merchant?,
                :current_admin?,
                :current_employee?

  def cart
    @cart ||= Cart.new(session[:cart])
  end

  def generate_flash(resource)
    resource.errors.messages.each do |validation, message|
      flash[validation] = "#{validation}: #{message}"
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?
    current_user&.user?
  end

  def current_employee?
    current_user&.employee?
  end

  def current_merchant?
    current_user&.merchant?
  end

  def current_admin?
    current_user&.admin?
  end
end
