class Like < ActiveRecord::Base
  attr_accessible :likeable_id, :likeable_type, :guest_id
  belongs_to :likeable, :polymorphic => true
  belongs_to :guest

end
