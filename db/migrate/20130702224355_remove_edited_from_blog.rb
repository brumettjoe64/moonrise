class RemoveEditedFromBlog < ActiveRecord::Migration
  def change
    remove_column :blogs, :lastedited
  end
end
