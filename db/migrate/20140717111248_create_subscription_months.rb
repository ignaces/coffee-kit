class CreateSubscriptionMonths < ActiveRecord::Migration
  def change
    create_table :subscription_months do |t|
      t.references :subscription, index: true
      t.references :shipment, index: true
      t.date :month 
      t.string :coffee_beans_ids, array: true, default: []
      t.integer :status

      t.timestamps
    end
  end
end
