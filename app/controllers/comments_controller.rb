class CommentsController < ApplicationController
  def create
    @comment = Comment.create(params[:comment].merge(guest_id: session_guest.id))
    @commentable = @comment.commentable
    @expand = false
    respond_to do |format|
      format.html { redirect_to home_path }
      format.js { render '_comment_box_update.js.erb' }
    end
  end

  def expand
    @commentable = commentable_lookup(params[:ctype], params[:cid])
    @expand = true
    respond_to do |format| 
      format.js { render '_comment_box_update.js.erb' }
    end
  end

  def collapse
    @commentable = commentable_lookup(params[:ctype], params[:cid])
    @expand = false
    respond_to do |format| 
      format.js { render '_comment_box_update.js.erb' }
    end  
  end

  def destroy
    @comment = Comment.find(params[:id])
    @commentable = @comment.commentable
    @comment.destroy
    @expane = false
    respond_to do |format|
      format.html { redirect_to home_path }
      format.js { render '_comment_box_update.js.erb' }
    end
  end
end
