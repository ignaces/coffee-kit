class AddEmailTimestampToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :confirmation_email_sent_at, :timestamp
  end
end
