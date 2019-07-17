class Merchant::BaseController < ApplicationController
  before_action :require_merchant

  private

  def require_merchant
    unless current_merchant?
      render file: '/public/404', status: 404, layout: false
    end
  end
end
