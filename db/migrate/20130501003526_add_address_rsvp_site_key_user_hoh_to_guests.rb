class AddAddressRsvpSiteKeyUserHohToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :addrst, :string
    add_column :guests, :addrcity, :string
    add_column :guests, :addrstate, :string
    add_column :guests, :addrzip, :string
    add_column :guests, :rsvp, :string
    add_column :guests, :sitekey, :string
    add_column :guests, :manager_id, :integer
  end
end
