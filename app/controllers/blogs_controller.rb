class BlogsController < ApplicationController
  before_filter :admin_authorize
  skip_before_filter :admin_authorize, only: [:index, :show]

  # GET /blogs/new
  # GET /blogs/new.json
  def new
    @blog = Blog.new
    @guest_id= session[:guest_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blog }
    end
  end

  # GET /blogs/1/edit
  def edit
    @blog = Blog.find(params[:id])
    @guest_id= session[:guest_id]

    respond_to do |format|
      format.html # edit.html.erb
      format.json { render json: @blog }
    end

  end

  def index
    session_guest.hit_logger("blog")
    @blogs_by_column = Blog.get_blogs_by_column
    @blogs_left = @blogs_by_column[0]
    @blogs_right = @blogs_by_column[1]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blogs }
    end
  end

  def admin
    @blogs = Blog.all.sort_by{ |blog| blog.created_at }.reverse
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blogs }
    end    
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(params[:blog])
    respond_to do |format|
      if @blog.save
        format.html { redirect_to admin_blogs_path, notice: 'Blog was successfully created.' }
        format.json { render json: @blog, status: :created, location: @blog }
      else
        format.html { render action: "new" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /blogs/1
  # PUT /blogs/1.json
  def update
    @blog = Blog.find(params[:id])
    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        format.html { redirect_to admin_blogs_path, notice: 'Blog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to admin_blogs_path }
      format.json { head :no_content }
    end
  end

end
