class AddPasswordAndAdminToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :admin, :boolean, :default => false
    add_column :guests, :password_digest, :string
  end
end
