class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.string :description
      t.datetime :when

      t.timestamps
    end
  end
end
