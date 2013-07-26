class Photo < ActiveRecord::Base
  attr_accessible :caption, :guest_id, :tag, :pic
  has_attached_file :pic, :styles => { :original => ["1500x1500>", :jpg], :medium => ["480x480>", :jpg], :thumb => ["100x100>", :jpg]}, :default_url => "holder100x100.jpg"
  validates_attachment_presence :pic
  VALID_TAGS = ["K", "L", "K+L", ""]
def guest
    unless guest_id.nil?
      Guest.find(guest_id)
    end
  end
  
end
