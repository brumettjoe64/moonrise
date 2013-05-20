require 'bcrypt'

class Guest < ActiveRecord::Base
  include BCrypt

  has_many :plusones, :class_name => "Guest", :foreign_key => "invitee_id", :dependent => :destroy
  belongs_to :invitee, :class_name => "Guest"

  attr_accessible :sitekey, :status, :email, :firstname, :lastname, :addrst, :addrcity, :addrstate, :addrzip, :invitee_id, :admin

  validates_uniqueness_of :email, :allow_blank => true, :allow_nil => true  
  validates_uniqueness_of :sitekey, :allow_blank => true, :allow_nil => true
  
  validate :check_status
  validate :check_invitee
  validate :check_password
  validate :check_invitee_email   

  VALID_STATUSES = [:new_guest, :registered_guest, :going, :not_going]

  # Password encoding for admins
  def password
    @password ||= Password.new(password_digest)
  end
  def password=(new_password)
    # if old password exists 
    if !self.password_digest.nil?
      # if new password is not blank
      if !new_password.nil? and !new_password.empty?
        # set new password
        @password = Password.create(new_password) 
        self.password_digest = @password
      # if new password is blank, do nothing
      end
    # if old password is blank
    else
      if !new_password.nil? and !new_password.empty?
        # set new password
        @password = Password.create(new_password) 
        self.password_digest = @password
      end
    end      
  end

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
    [self] + self.plusones.order(:id) if invitee? 
  end

  def invitee?
    invitee_id.nil?
  end

  def plusone?
    !self.invitee?
  end

  def admin?
    self.admin
  end
  
  def registered?
    self.status != "new_guest" 
  end



  def check_invitee_email
    if self.invitee? and self.status == "registered_guest" and self.email.blank?
      errors.add(:email, "is required for head invitee")
    end
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

  def check_password
    if self.admin? and self.password_digest.nil?
      errors.add(:password, " required for admins") 
    end
  end

end
