class GuestsPhotos < ActiveRecord::Migration
  def change
    rename_column :photos, :guest_id, :poster_id
  end
end
