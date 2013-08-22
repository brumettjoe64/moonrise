class AddHitsCounter < ActiveRecord::Migration
  def change
    add_column :guests, :home_ts, :datetime
    add_column :guests, :home_hits, :integer, :default => 0
    add_column :guests, :blog_ts, :datetime
    add_column :guests, :blog_hits, :integer, :default => 0
    add_column :guests, :photo_ts, :datetime
    add_column :guests, :photo_hits, :integer, :default => 0
    add_column :guests, :details_ts, :datetime
    add_column :guests, :details_hits, :integer, :default => 0
    add_column :guests, :ri_ts, :datetime
    add_column :guests, :ri_hits, :integer, :default => 0
  end
end
