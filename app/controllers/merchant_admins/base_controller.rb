class MerchantAdmins::BaseController < ApplicationController
  before_action :require_merchant_access

  private
    # def require_merchant_admin
    #   unless current_merchant_admin?
    #     render file: "/public/404", status: 404
    #   end
    # end

		def require_merchant_access
			unless current_merchant_employee? || current_merchant_admin?
				render file: "/public/404", status: 404
			end
		end
end
