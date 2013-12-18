class Email < ActiveRecord::Base
  attr_accessible :from, :guest_id, :group_id, :html, :subject, :plain, :sendtime
  belongs_to :group
  belongs_to :guest
end
