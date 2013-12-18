class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :from
      t.string :subject
      t.integer :guest_id
      t.integer :group_id
      t.text :plain
      t.text :html
      t.boolean :sent
      t.timestamps
    end
  end
end
