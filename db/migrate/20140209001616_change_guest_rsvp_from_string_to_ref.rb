class ChangeGuestRsvpFromStringToRef < ActiveRecord::Migration
  def change
    remove_column :guests, :rsvp
    add_column :guests, :rsvp_id, :integer
  end
end
