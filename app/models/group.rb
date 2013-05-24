class Group < ActiveRecord::Base
  has_and_belongs_to_many :guests, autosave: true

  attr_accessible :name

end
