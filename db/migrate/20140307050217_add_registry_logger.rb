class AddRegistryLogger < ActiveRecord::Migration
  def change
    add_column :guests, :registry_ts, :datetime
    add_column :guests, :registry_hits, :integer, :default => 0
  end
end
