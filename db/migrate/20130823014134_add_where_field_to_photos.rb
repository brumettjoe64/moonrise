class AddWhereFieldToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :where, :string, :default => ""
    add_column :blogs, :width, :integer, :default => 0
    add_column :blogs, :height, :integer, :default => 0
  end
end
