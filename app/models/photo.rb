class Photo < ActiveRecord::Base
  attr_accessible :caption, :poster_id, :tag, :pic, :when
  has_attached_file :pic, :styles => { :original => ["1500x1500>", :jpg], :medium => ["480x480>", :jpg], :thumb => ["100x100>", :jpg]}, :default_url => "holder480x480.jpg"
  belongs_to :poster, :class_name => "Guest"
  validates_attachment_presence :pic
  has_and_belongs_to_many :guests, autosave: true
def guest
    unless guest_id.nil?
      Guest.find(guest_id)
    end
  end  
end
