class RsvpsController < ApplicationController
  
  def show
  end

  def modify
    session_guest.party.each_with_index do |pm,index|
      @guest = Guest.find(params[:guest_id][index])
      @rsvp  = @guest.rsvp || Rsvp.create(guest_id: @guest.id)
      @guest.add_rsvp(@rsvp)


      wedding = params[:wedding][index] 
      tea = params[:tea][index]
      nosurf = params[:nosurf][index]
      noturf = params[:noturf][index]
      rsvp_par = Hash.new()

      if (wedding == "true")
        rsvp_par[:wedding] = true
        rsvp_par[:tea] = (tea == "nil") ? nil : tea
        rsvp_par[:nosurf] = (nosurf == "true") ? true : false
        rsvp_par[:noturf] = (noturf == "true") ? true : false
      elsif (wedding == "false")
        rsvp_par[:wedding] = false
        rsvp_par[:tea] = nil
        rsvp_par[:nosurf] = nil
        rsvp_par[:noturf] = nil
      else 
        rsvp_par[:wedding] = nil
        rsvp_par[:tea] = nil
        rsvp_par[:nosurf] = nil
        rsvp_par[:noturf] = nil
      end
      @rsvp.update_attributes(rsvp_par)
      @rsvp.save  
    end

    respond_to do |format|
      format.js { render '_show.js.erb' }
    end

  end

  def destroy
    #@like = Like.find(params[:id])
    #@likeable = @like.likeable
    #@like.destroy
    #respond_to do |format|
    #  format.html { redirect_to home_path }
    #  format.js { render '_like_bar_update.js.erb' } 
    #end
  end


end
