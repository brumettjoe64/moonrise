class ChangeRsvpName < ActiveRecord::Migration
  def change
    rename_column :guests, :rsvp, :status
  end
end
