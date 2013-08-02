class PhotosController < ApplicationController
  before_filter :admin_authorize
  skip_before_filter :admin_authorize, only: [:index, :show, :new, :edit, :create, :update, :destroy]

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end

  def admin
    @photos = Photo.all.sort_by{ |photo| photo.created_at }.reverse
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blogs }
    end    
  end


  # GET /photos/new
  # GET /photos/new.json
  def new
    @photo = Photo.new
    @poster_id = session[:guest_id]
    @groom = Group.find_by_name(:Groom).guests.first
    @bride = Group.find_by_name(:Bride).guests.first

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
    @poster_id = @photo.poster_id
    @groom = Group.find_by_name(:Groom).guests.first
    @bride = Group.find_by_name(:Bride).guests.first


  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(params[:photo])
    @groom = Group.find_by_name(:Groom).guests.first
    @bride = Group.find_by_name(:Bride).guests.first
    respond_to do |format|
      if @photo.save
        taggable_guests = [@groom, @bride]

        taggable_guests.each do |taggable_guest|
          unless params.has_key?(:taglist) and params[:taglist][taggable_guest.id.to_s] == "true"  
            @photo.guests << taggable_guest unless @photo.guests.include?(taggable_guest)
          else
            @photo.guests.delete(taggable_guest) if @photo.guests.include?(taggable_guest)
          end
        end
        format.html { redirect_to photos_path, notice: 'Photo was successfully created.' }
        format.json { render json: @photo, status: :created, location: @photo }
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.json
  def update
    @photo = Photo.find(params[:id])
    @groom = Group.find_by_name(:Groom).guests.first
    @bride = Group.find_by_name(:Bride).guests.first
    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        taggable_guests = [@groom, @bride]

        taggable_guests.each do |taggable_guest|
          if params.has_key?(:taglist) and params[:taglist][taggable_guest.id.to_s] == "true"  
            @photo.guests << taggable_guest unless @photo.guests.include?(taggable_guest)
          else
            @photo.guests.delete(taggable_guest) if @photo.guests.include?(taggable_guest)
          end
        end
        format.html { redirect_to photos_path, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end
end
