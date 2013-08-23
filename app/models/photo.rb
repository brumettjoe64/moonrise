class Photo < ActiveRecord::Base
  attr_accessible :caption, :poster_id, :tag, :pic, :when, :where
  has_attached_file :pic, :styles => { :original => ["1500x1500>", :jpg], :medium => ["480x480>", :jpg], :thumb => ["100x100>", :jpg]}, :default_url => "image-blank.png"
  belongs_to :poster, :class_name => "Guest"
  validates_attachment_presence :pic
  validate :file_dimensions
  has_and_belongs_to_many :guests, autosave: true

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

  def file_dimensions
    new_photo_path = (pic.queued_for_write[:original]) ? pic.queued_for_write[:original].path : nil
    old_photo_path = (pic.options[:storage] == :s3) ? pic.url(:original) : pic.path(:original)
    dimensions = Paperclip::Geometry.from_file(new_photo_path || old_photo_path)
    self.width = dimensions.width.to_int
    self.height = dimensions.height.to_int
  end

  def self.update_file_dimensions
    Photo.all.each do |photo|
      photo.file_dimensions
      photo.save
    end
  end

  def to_json()
    h = super(only: [:id, :caption, :poster, :when, :where, :image_s, :image_m, :image_l, :height, :width, :created_at], :include => {:guests => {:only => [:id, :firstname]}});
  end

  def as_json(options = { })
    h = super(options)
    h[:image_s] = pic.url(:thumb)
    h[:image_m] = pic.url(:medium)
    h[:image_l] = pic.url(:original)
    h[:poster] = "#{poster.firstname} #{poster.lastname}"
    h
  end
end
