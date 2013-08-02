class AddDateTakenToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :when, :datetime
  end
end
