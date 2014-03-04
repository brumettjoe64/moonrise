class RemoveRsvpInfosFromGuest < ActiveRecord::Migration
  def change
    remove_column :guests :rsvp_info
  end
end
