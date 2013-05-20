class HomeController < ApplicationController
  def index
    @guest = Guest.find_by_id(session[:guest_id])
  end
end
