class ChangePicToAttachment < ActiveRecord::Migration
  def up
    add_attachment :blogs, :pic
  end

  def down
    remove_attachment :blogs, :pic
  end
end
