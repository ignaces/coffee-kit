class CreateSubscriptionPlanEntries < ActiveRecord::Migration
  def change
    create_table :subscription_plan_entries do |t|
      t.references :subscription_plan, index: true
      t.integer :period_quantity
      t.decimal :price, default: 0

      t.timestamps
    end
  end
end
