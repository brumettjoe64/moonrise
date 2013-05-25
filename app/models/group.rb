class Group < ActiveRecord::Base
  has_and_belongs_to_many :guests, autosave: true
  attr_accessible :name
  validates_uniqueness_of :name  
  validates_presence_of :name
end
