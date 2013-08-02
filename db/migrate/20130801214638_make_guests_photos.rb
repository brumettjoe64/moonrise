class MakeGuestsPhotos < ActiveRecord::Migration
 def up
    create_table :guests_photos, :id => false do |t|
      t.references :guest, :null => false
      t.references :photo, :null => false
    end
    add_index(:guests_photos, [:guest_id, :photo_id], :unique=>true)
  end

  def down
    drop_table :guests_photos
  end
end
