class Rsvp < ActiveRecord::Base
  belongs_to :guest
  attr_accessible :nosurf, :noturf, :tea, :wedding, :guest_id
  
end
