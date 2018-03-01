class AddCompletedAtToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :completed_at, :timestamp
  end
end
