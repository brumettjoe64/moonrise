class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :guest_id
      t.integer :likeable_id
      t.string :likeable_type
      t.timestamps
      t.references :likeable, :polymorphic => true
    end
  end
end
