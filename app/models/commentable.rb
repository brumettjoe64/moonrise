module Commentable
  def is_commentable
    has_many :comments, :as=>:commentable, :dependent=>:destroy, :order=> 'created_at DESC'
    include InstanceMethods
  end

  module InstanceMethods
    def commentable?
      true
    end

    def commented_by?(guest)
      Comment.where(commentable_id: id, commentable_type: self.class.name, guest_id: guest.id).first
    end

    def comments_count
      self.comments.count
    end

    def comments_display

    end
  end
end
ActiveRecord::Base.extend Commentable
