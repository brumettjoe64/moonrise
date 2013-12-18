class EmailsController < ApplicationController
  before_filter :admin_authorize

  def ship
    @email = Email.find(params[:id])

    @email.group.guests.each do |r|
      if !r.email.nil? && !r.email.blank?
        AdminMailer.ship(@email,r).deliver
      end
    end

    respond_to do |format|
      if @email.update_attributes(:sendtime => Time.now)
        format.html { redirect_to admin_emails_path, notice: 'Email was successfully sent.' }
      else
        format.html {  redirect_to admin_emails_path, alert: 'Email was not succesfully sent.' }
      end
    end
  end

  def admin
    @emails = Email.all.sort_by{ |email| email.created_at }.reverse
  end

  def new
    @email = Email.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @email = Email.new(params[:email].merge(guest_id: session_guest.id))
    respond_to do |format|
      if @email.save
        format.html { redirect_to admin_emails_path, notice: 'Email was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def edit
    @email = Email.find(params[:id])
  end

  def update
    @email = Email.find(params[:id])
    respond_to do |format|
      if @email.save and @email.update_attributes(params[:email])
        format.html { redirect_to admin_emails_path, notice: 'Email was successfully updated.' }
      else
        format.html { render action: "new" }
      end
    end
  end
end

