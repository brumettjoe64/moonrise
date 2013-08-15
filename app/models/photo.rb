class Photo < ActiveRecord::Base
  attr_accessible :caption, :poster_id, :tag, :pic, :when
  has_attached_file :pic, :styles => { :original => ["1500x1500>", :jpg], :medium => ["480x480>", :jpg], :thumb => ["100x100>", :jpg]}, :default_url => "image-blank.png"
  belongs_to :poster, :class_name => "Guest"
  validates_attachment_presence :pic
  has_and_belongs_to_many :guests, autosave: true
  def guest
    unless guest_id.nil?
      Guest.find(guest_id)
    end
  end  

  def self.get_photos_by_date
    Photo.all.sort_by{ |photo| photo.created_at }.reverse
  end

  def self.get_photos_of(person, *others)
    photos_list = person.photos
    photos_list_temp = []

    if others.count == 0 
      photos_list.each do |photo|
        if photo.guests.count == 1
          photos_list_temp << photo
        end
      end
    elsif others.count == 1
      photos_list.each do |photo|
        if photo.guests.include?(others.first)
          photos_list_temp << photo
        end
      end
    end
    photos_list = photos_list_temp.sort_by{ |photo| photo.when }.reverse
  end 

  def to_json_for_photo_form
    to_json(only: [:id, :caption, :poster_id, :when], :include => {:guests => {:only => [:id, :firstname]}});
  end
end
