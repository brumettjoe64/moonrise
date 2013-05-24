class GuestsGroups < ActiveRecord::Migration
  def up
    create_table :groups_guests, :id => false do |t|
      t.references :guest, :null => false
      t.references :group, :null => false
    end
    add_index(:groups_guests, [:group_id, :guest_id], :unique=>true)
  end

  def down
    drop_table :groups_guests
  end
end
