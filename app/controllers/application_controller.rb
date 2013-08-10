class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize
  helper_method :session_guest

  def session_guest
    @session_guest  ||= Guest.find_by_id(session[:guest_id])
  end

  protected
    def authorize
      unless session_guest
        redirect_to login_url
      end
    end

    def admin_authorize 
      unless session_guest.admin
        redirect_to home_url, alert: "action requires admin access"
      end
    end

end
