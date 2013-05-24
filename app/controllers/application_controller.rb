class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize

  protected
    def authorize
      unless Guest.find_by_id(session[:guest_id])
        redirect_to login_url
      end
    end

    def admin_authorize 
      unless Guest.find_by_id(session[:guest_id]).admin
        redirect_to home_url, alert: "action requires admin access"
      end
    end

end
