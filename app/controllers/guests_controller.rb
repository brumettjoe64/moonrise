class GuestsController < ApplicationController
  before_filter :admin_authorize
  skip_before_filter :admin_authorize, only: [:index, :update_info] #, :edit_rsvp, :update_rsvp]
  skip_before_filter :authorize, only: [:edit_info, :update_info]

  # GET /guests
  # GET /guests.json
  
  # GET /guests/admin
  # GET /guests/admin.json


  def admin
    @guests = Guest.order(:firstname).all
    @invitees = Guest.order(:firstname).where(invitee_id: nil)
    @registered = Guest.where(account_flag: true)
    @gos = Guest.where(rsvp: :going)    
    @nos = Guest.where(rsvp: :not_going)    
    @maybes = Guest.where(rsvp: :no_reply)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @guests }
    end
  end

  # GET /guests/1
  # GET /guests/1.json
  def show
    @guest = Guest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @guest }
    end
  end

  # GET /guests/new
  # GET /guests/new.json
  def new
    @guest = Guest.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @guest }
    end
  end

  # GET /guests/1/edit
  def edit
    @guest = Guest.find(params[:id])
  end

  # GET /guests/rsvp
  def edit_rsvp
    @guest = Guest.find_by_id(session[:guest_id])
    @party = @guest.party
  end


  # POST /guests
  # POST /guests.json
  def create
    @guest = Guest.new(params[:guest])
    @guest.password = params[:password]
    respond_to do |format|
      if @guest.save
        format.html { redirect_to admin_guests_path, notice: 'Guest was successfully created.' }
        format.json { render json: @guest, status: :created, location: @guest }
      else
        format.html { render action: "new" }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /guests/1
  # PUT /guests/1.json
  def update
    @guest = Guest.find(params[:id])
    @guest.password = params[:password]
    respond_to do |format|
      if @guest.save and @guest.update_attributes(params[:guest])
        format.html { redirect_to admin_guests_path, notice: 'Guest was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT guests/rsvp
  def update_rsvp
    @guest = Guest.find_by_id(session[:guest_id])
    @party = @guest.party

    successful_save = true
    
    @party.each do |pm|
      unless !successful_save
        pm.rsvp = params["rsvp"][pm.id.to_s]
        pm.rsvp_info = params["rsvp_info"][pm.id.to_s]
        successful_save = pm.save
      end 
    end

    respond_to do |format|
      if successful_save
        format.html { redirect_to home_path, notice: 'RSVP was successfully modified.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit_info" }
        format.json { render json: pm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT guests/modify
  def update_info
    @guest = Guest.find_by_id(session[:guest_id])
    @guest.account_flag = true 
    @party = @guest.party

    successful_save = true
    
    for i in 0..@party.length-1
      unless !successful_save
        @party_member = @party[i]
        @party_member.firstname = params["firstnames"][i]
        @party_member.lastname  = params["lastnames"][i]
        @party_member.email     = params["emails"][i]   
        successful_save = @party_member.save
      end 
    end

    respond_to do |format|
      if successful_save
        format.html { redirect_to home_path, notice: 'Guest info was successfully modified.' }
        format.json { head :no_content }
      else
        format.html { redirect_to home_path, alert: 'There was a problem with the guest info submitted.' }
        format.json { render json: @party_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guests/1
  # DELETE /guests/1.json
  def destroy
    @guest = Guest.find(params[:id])
    @guest.destroy

    respond_to do |format|
      format.html { redirect_to admin_guests_path }
      format.json { head :no_content }
    end
  end

end
