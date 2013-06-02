class DetailsController < ApplicationController
  before_filter :admin_authorize
  skip_before_filter :admin_authorize, only: [:index]
  # GET /details
  # GET /details.json

  def index
    @guest = Guest.find_by_id(session[:guest_id])
    @groups = @guest.groups

    @details = @guest.details
    @groups.each do |group|
      @details |= group.details
    end

    @details = @details.sort_by { |detail| detail.when }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @details }
    end
  end

  def admin
    @details = Detail.all.sort_by { |detail| detail.when }
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @details }
    end
  end

  # GET /details/1
  # GET /details/1.json
  def show
    @detail = Detail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @detail }
    end
  end

  # GET /details/new
  # GET /details/new.json
  def new
    @detail = Detail.new
    @guests = Guest.all_by_name
    @groups = Group.all_by_name
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @detail }
    end
  end

  # GET /details/1/edit
  def edit
    @detail = Detail.find(params[:id])
    @guests = Guest.all_by_name
    @groups = Group.all_by_name
  end

  # POST /details
  # POST /details.json
  def create
    @detail = Detail.new(params[:detail])
    @guests = Guest.all_by_name
    @groups = Group.all_by_name
    respond_to do |format|
      if @detail.save
        @guests.each do |guest|
          if params.has_key?(:guest_assign) and params[:guest_assign][guest.id.to_s] == "true"
            @detail.guests << guest unless @detail.guests.include?(guest)
          else
            @detail.guests.delete (guest) if @detail.guests.include?(guest)
          end
        end
        @groups.each do |group|
          if params.has_key?(:group_assign) and params[:group_assign][group.id.to_s] == "true"
            @detail.groups << group unless @detail.groups.include?(group)
          else
            @detail.groups.delete (group) if @detail.groups.include?(group)
          end 
        end  
        format.html { redirect_to admin_details_path, notice: 'Detail was successfully created.' }
        format.json { render json: @detail, status: :created, location: @detail }
      else
        format.html { render action: "new" }
        format.json { render json: @detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /details/1
  # PUT /details/1.json
  def update
    @detail = Detail.find(params[:id])
    @guests = Guest.all_by_name
    @groups = Group.all_by_name
    respond_to do |format|
      if @detail.update_attributes(params[:detail])
        @guests.each do |guest|
          if params.has_key?(:guest_assign) and params[:guest_assign][guest.id.to_s] == "true"
            @detail.guests << guest unless @detail.guests.include?(guest)
          else
            @detail.guests.delete (guest) if @detail.guests.include?(guest)
          end
        end
        @groups.each do |group|
          if params.has_key?(:group_assign) and params[:group_assign][group.id.to_s] == "true"
            @detail.groups << group unless @detail.groups.include?(group)
          else
            @detail.groups.delete (group) if @detail.groups.include?(group)
          end 
        end  
        format.html { redirect_to admin_details_path, notice: 'Detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /details/1
  # DELETE /details/1.json
  def destroy
    @detail = Detail.find(params[:id])
    @detail.destroy

    respond_to do |format|
      format.html { redirect_to admin_details_path }
      format.json { head :no_content }
    end
  end
end
