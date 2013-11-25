module Likeable
  def is_likeable
    has_many :likes, :as=>:likeable, :dependent=>:destroy
    include InstanceMethods
  end
  module InstanceMethods
    def likeable?
      true
    end

    def liked_by?(guest)
      Like.where(likeable_id: id, likeable_type: self.class.name, guest_id: guest.id).first
    end

    def likes_count
      self.likes.count
    end

    def likes_display
      if likes_count == 0
        "Be the first to like this "+ self.class.name.downcase+"."
      else
        ordered_likes = likes.sort_by(&:created_at).reverse

        if likes_count == 1 
          ordered_likes.first.guest.firstname.titleize+" likes this "+self.class.name.downcase+"."
        elsif likes_count == 2
          ordered_likes.first.guest.firstname.titleize+" and "+ordered_likes.second.guest.firstname.titleize+" like this "+ self.class.name.downcase+"."
        else
          ordered_likes.first.guest.firstname.titleize +
          " and " +
          "<span class='liked_by_trigger'>" +
          (ordered_likes.count-1).to_s +
          " others" +
          "</span>" +
          " like this " + self.class.name.downcase + "."
        end
      end
    end

    def likes_display_guest_list
      guest_list = []
      if likes_count > 2
        ordered_likes = likes.sort_by(&:created_at).reverse
        ordered_likes.shift
        ordered_likes.each do |like_to_display|
          guest_list << like_to_display.guest
        end
      end
      guest_list
    end

  end
end
ActiveRecord::Base.extend Likeable
