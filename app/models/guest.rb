class Guest < ActiveRecord::Base
  has_many :plusones, :class_name => "Guest", :foreign_key => "invitee_id", :dependent => :destroy
  belongs_to :invitee, :class_name => "Guest"

  attr_accessible :sitekey, :status, :email, :firstname, :lastname, :addrst, :addrcity, :addrstate, :addrzip, :invitee_id

  VALID_STATUSES = [:new_guest, :registered_guest, :going, :not_going]
  
  validate :check_status
  validate :check_invitee   

  def initials
    if firstname and lastname
      firstname.first+lastname.first
    else
      ""
    end
  end
 
  def invitee
    unless invitee_id.nil?
      Guest.find(invitee_id)
    else
      self
    end
  end

  def party
    [self] + self.plusones if invitee? 
  end

  def invitee?
    invitee_id.nil?
  end

  def plusone?
    !self.invitee?
  end
    
  def check_invitee

    if !invitee_id.nil?
      invitee = Guest.find_by_id(invitee_id)

      if !invitee         
        errors.add(:invitee_id, "must exist in the database") 
      elsif !invitee.invitee?
        errors.add(:invitee_id, "cannot be a plus one")
      end
    end 
  end

  def check_status
    errors.add(:status, "is not a valid status") unless VALID_STATUSES.include?(status.to_sym)
  end
end
