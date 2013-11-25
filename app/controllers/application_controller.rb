class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize
  helper_method :session_guest, :groom, :bride, :photo_authorize, :comment_authorize, :hit_logger

  def session_guest
    @session_guest  ||= Guest.find_by_id(session[:guest_id])
  end

  def groom
    @groom ||= Group.find_by_name("Groom").guests.first
  end

  def bride
    @bride ||= Group.find_by_name("Bride").guests.first
  end

  def photo_authorize(photo)
    session_guest.admin || (photo.poster == session_guest)
  end

  def comment_authorize(comment)
    session_guest.admin || (comment.guest == session_guest)
  end

  def commentable_lookup(type, id)
    case type
      when "Blog"
        Blog.find(id)
      when "Photo"
        Photo.find(id)
      else 
        nil
    end
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
