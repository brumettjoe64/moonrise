class Blog < ActiveRecord::Base
  attr_accessible :body, :title, :pic, :guest_id, :when
  belongs_to :guest
  has_attached_file :pic, :styles => { :original => ["1500x1500>", :jpg], :medium => ["480x480>", :jpg], :thumb => ["100x100>", :jpg]}, :default_url => "image-blank.png"
  validate :file_dimensions

  is_likeable 
  is_commentable

  def guest
    unless guest_id.nil?
      Guest.find(guest_id)
    end
  end
  
  def self.get_blogs_by_date
    Blog.all.sort_by{ |blog| blog.created_at }.reverse
  end
  
  def self.get_blogs_by_column
    blogs = Blog.all.sort_by{ |blog| blog.created_at }.reverse
    height_left = 0
    height_right = 0
    blogs_left = []
    blogs_right = []
    blogs_by_column = []

    blogs.each do |blog| 

      if height_left > height_right
        height_right += blog.height.to_f/blog.width
        blogs_right << blog
      else
        blogs_left << blog
        height_left += blog.height.to_f/blog.width
      end
    end

    blogs_by_column[0] = blogs_left
    blogs_by_column[1] = blogs_right
    blogs_by_column
  end 

  def file_dimensions
    new_photo_path = (pic.queued_for_write[:original]) ? pic.queued_for_write[:original].path : nil
    old_photo_path = (pic.options[:storage] == :s3) ? pic.url(:original) : pic.path(:original)
    dimensions = Paperclip::Geometry.from_file(new_photo_path || old_photo_path)
    self.width = dimensions.width.to_int
    self.height = dimensions.height.to_int
  end

  def self.update_file_dimensions
    Blog.all.each do |blog|
      blog.file_dimensions
      blog.save
    end
  end


  def to_json()
    h = super(only: [:body, :title, :poster, :when, :image_s, :image_m, :image_l, :height, :width, :created_at])
  end

  def as_json(options = { })
    h = super(options)
    h[:image_s] = pic.url(:thumb)
    h[:image_m] = pic.url(:medium)
    h[:image_l] = pic.url(:original)
    h[:poster] = "#{self.guest.firstname} #{self.guest.lastname}"
    h
  end


end
