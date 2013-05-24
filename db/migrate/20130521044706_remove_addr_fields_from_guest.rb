class RemoveAddrFieldsFromGuest < ActiveRecord::Migration
  def up
    remove_column :guests, :addrst
    remove_column :guests, :addrcity
    remove_column :guests, :addrstate
    remove_column :guests, :addrzip  
  end

  def down
    add_column :guests, :addrst, :string
    add_column :guests, :addrcity, :string
    add_column :guests, :addrstate, :string
    add_column :guests, :addrzip, :string  
  end
end
