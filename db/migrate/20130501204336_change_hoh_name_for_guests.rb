class ChangeHohNameForGuests < ActiveRecord::Migration
  def change
    rename_column :guests, :manager_id, :head_id
  end
end
