class Detail < ActiveRecord::Base
  attr_accessible :description, :when
  has_and_belongs_to_many :guests, autosave: true
  has_and_belongs_to_many :groups, autosave: true  
end
