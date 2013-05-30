class GroupsController < ApplicationController
  before_filter :admin_authorize
  # GET /groups
  # GET /groups.json

  def index
    @groups = Group.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new
    @guests = Guest.all_by_name
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
    @guests = Guest.all_by_name
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(params[:group])
    @guests = Guest.all_by_name
    respond_to do |format|
      if @group.save
        format.html { redirect_to groups_url, notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])
    @guests = Guest.all_by_name
    @guests.each do |guest|
      if params[:member][guest.id.to_s] == "true"
        @group.guests << guest unless @group.guests.include?(guest)
      else
        @group.guests.delete (guest) if @group.guests.include?(guest)
      end
    end  

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to groups_url, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end
end
