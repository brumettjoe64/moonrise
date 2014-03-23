require 'bcrypt'

class Guest < ActiveRecord::Base
  include BCrypt

  has_many :plusones, :class_name => "Guest", :foreign_key => "invitee_id", :dependent => :destroy
  has_many :photoposts, :class_name => "Photo",:foreign_key => "poster_id", :dependent => :destroy
  has_many :blogs, :dependent => :destroy
  has_many :likes, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  belongs_to :invitee, :class_name => "Guest"
  has_and_belongs_to_many :groups, autosave: true
  has_and_belongs_to_many :details, autosave: true
  has_and_belongs_to_many :photos, autosave: true
  has_one :rsvp

  attr_accessible :sitekey, :email, :firstname, :lastname, :invitee_id, :admin, :account_flag, :rsvp_id 

  validates_uniqueness_of :email, :allow_blank => true, :allow_nil => true  
  validates_uniqueness_of :sitekey, :allow_blank => true, :allow_nil => true
  
  validate :check_invitee
  validate :check_password
  validate :check_invitee_email   

  after_create :add_to_Everyone

  # Password encoding for admins

  def add_rsvp(rsvp_obj)
    self.rsvp_id = rsvp_obj.id
    self.save
  end

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

  def display_name
    if !firstname.blank? and !lastname.blank?
      "#{firstname} #{lastname}".titleize
    elsif self.invitee?
      "Invitee"
    else
      "#{invitee.firstname}'s Plus One"
    end
  end

  def login_name
    if invitee? and party.count > 1
      firstname + "+" + (party.count-1).to_s
    else
      firstname
    end
  end

  def login_icon
    if invitee? and party.count > 1
      '<i class="fa fa-group"></i> '.html_safe
    else
      '<i class="fa fa-user"></i> '.html_safe
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

  def self.all_by_name
    Guest.all.sort {|a,b| a.display_name <=> b.display_name}    
  end

  def party
    if invitee?
      [self] + self.plusones.order(:id) 
    else
      [self]
    end
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
    #self.account_flag 
    self.email != ""
  end

  def display_status
    if self.invitee?
      if self.registered?  
        status = ""
        status += (self.rsvp && !self.rsvp.wedding.nil?) ? (self.rsvp.wedding ? "Go   " : "NoGo ") : "N/A  "
        status += (self.rsvp && !self.rsvp.wedding.nil?) ? (self.rsvp.tea ? "Tea   " : "NoTea ") : "N/A   "
        status += (self.rsvp && !self.rsvp.wedding.nil?) ? (self.rsvp.noturf ? "NoBeef " : "       ") : "N/A    "
        status += (self.rsvp && !self.rsvp.wedding.nil?) ? (self.rsvp.nosurf ? "NoSurf " : "       ") : "N/A    "
        status
      else
        "no_login"
      end
    else
      if self.invitee.registered?
        status = ""
        status += (self.rsvp && !self.rsvp.wedding.nil?) ? (self.rsvp.wedding ? "Go   " : "NoGo ") : "N/A  "
        status += (self.rsvp && !self.rsvp.wedding.nil?) ? (self.rsvp.tea ? "Tea   " : "NoTea ") : "N/A   "
        status += (self.rsvp && !self.rsvp.wedding.nil?) ? (self.rsvp.noturf ? "NoBeef " : "       ") : "N/A    "
        status += (self.rsvp && !self.rsvp.wedding.nil?) ? (self.rsvp.nosurf ? "NoSurf " : "       ") : "N/A    "
        status
      else
        "no_login"
      end
    end
  end
  def check_invitee_email
    if self.invitee? and self.account_flag and self.email.blank?
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

  def check_password
    if self.admin? and self.password_digest.nil?
      errors.add(:password, " required for admins") 
    end
  end

  def add_to_Everyone
    group_Everyone = Group.find_by_name(:Everyone) || Group.new(name: :Everyone)
    group_Everyone.save
    group_Everyone.guests << self
  end

  def hit_logger(cName)
    last_ts   = self.send(cName+"_ts")
    last_hits = self.send(cName+"_hits").to_i

    if ((!last_ts) || (last_ts < 2.hours.ago))
      self.send(cName+"_ts=", DateTime.now)
      self.send(cName+"_hits=", last_hits+1)
      self.save
    end
  end

end
