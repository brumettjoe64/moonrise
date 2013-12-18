class ChangeEmailSentToTime < ActiveRecord::Migration
  def change
    remove_column :emails, :sent
    add_column :emails, :sendtime, :datetime
  end
end
