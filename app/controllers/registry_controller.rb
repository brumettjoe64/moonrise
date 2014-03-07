class RegistryController < ApplicationController
  def index
    session_guest.hit_logger("registry")    
  end
end
