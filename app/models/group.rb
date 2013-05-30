class Group < ActiveRecord::Base
  has_and_belongs_to_many :guests, autosave: true
  has_and_belongs_to_many :details, autosave: true  
  attr_accessible :name
  validates_uniqueness_of :name  
  validates_presence_of :name

    def self.all_by_name
    Group.find(:all, order: "name")
  end

end
