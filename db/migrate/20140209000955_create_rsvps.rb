class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.boolean :wedding
      t.boolean :tea
      t.boolean :nosurf
      t.boolean :noturf
      t.integer :guest_id
      t.timestamps
    end
  end
end
