class ShuffleRsvpFields < ActiveRecord::Migration
  def up
    add_column :guests, :account_flag, :boolean, :default => false
    add_column :guests, :rsvp_info, :string
    rename_column :guests, :status, :rsvp
    change_column :guests, :rsvp, :string, :default=> :no_reply 
    guests = Guest.all
    guests.each do |g|
      g.rsvp = :no_reply
      g.save
    end
  end

  def down
    remove_column :guests, :account_flag
    remove_column :guests, :rsvp_info    
    rename_column :guests, :rsvp, :status
  end
end
