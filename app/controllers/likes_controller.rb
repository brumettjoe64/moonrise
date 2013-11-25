class LikesController < ApplicationController
  def create
    @like = Like.create(params[:like].merge(guest_id: session_guest.id))
    @likeable = @like.likeable
    respond_to do |format|
      format.html { redirect_to home_path }
      format.js { render '_like_bar_update.js.erb' }
    end
  end
  def destroy
    @like = Like.find(params[:id])
    @likeable = @like.likeable
    @like.destroy
    respond_to do |format|
      format.html { redirect_to home_path }
      format.js { render '_like_bar_update.js.erb' } 
    end
  end
end
