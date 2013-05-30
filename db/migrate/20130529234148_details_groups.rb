class DetailsGroups < ActiveRecord::Migration
  def up
    create_table :details_groups, :id => false do |t|
      t.references :group, :null => false
      t.references :detail, :null => false
    end
    add_index(:details_groups, [:detail_id, :group_id], :unique=>true)
  
    create_table :details_guests, :id => false do |t|
      t.references :guest, :null => false
      t.references :detail, :null => false
    end
    add_index(:details_guests, [:detail_id, :guest_id], :unique=>true)
  end

  def down
    drop_table :details_groups
    drop_table :details_guests
  end
end
