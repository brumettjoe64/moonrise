class HomeController < ApplicationController
  def index
    session_guest.hit_logger("home")
  end
end
