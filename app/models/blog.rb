class Blog < ActiveRecord::Base
  attr_accessible :body, :title, :pic, :guest_id, :when
  belongs_to :guest
  has_attached_file :pic, :styles => { :original => ["1500x1500>", :jpg], :medium => ["480x480>", :jpg], :thumb => ["100x100>", :jpg]}, :default_url => "image-blank.png"
  #has_attached_file :pic
  def guest
    unless guest_id.nil?
      Guest.find(guest_id)
    end
  end
  
  def img_height
    #self.pic.url(:medium)
      photo_path = (pic.options[:storage] == :s3) ? pic.url(:medium) : pic.path(:medium)
      Paperclip::Geometry.from_file(photo_path).height.to_int
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
        height_right += blog.img_height
        blogs_right << blog
      else
        blogs_left << blog
        height_left += blog.img_height
      end
    end

    blogs_by_column[0] = blogs_left
    blogs_by_column[1] = blogs_right
    blogs_by_column
  end 
end
