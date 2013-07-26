class RenameAuthorFromBlog < ActiveRecord::Migration
  def change
    rename_column :blogs, :author, :guest_id
  end
end
