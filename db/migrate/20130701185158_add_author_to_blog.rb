class AddAuthorToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :author, :integer
  end
end

