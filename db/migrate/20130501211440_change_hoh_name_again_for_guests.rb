class ChangeHohNameAgainForGuests < ActiveRecord::Migration
  def change
    rename_column :guests, :head_id, :invitee_id
  end
end
