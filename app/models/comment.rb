class Comment < ActiveRecord::Base
  attr_accessible :message, :commentable_id, :commentable_type, :guest_id
  belongs_to :commentable, :polymorphic => true
  belongs_to :guest
end
