class RiController < ApplicationController
  def index
    session_guest.hit_logger("ri")
  end
end
