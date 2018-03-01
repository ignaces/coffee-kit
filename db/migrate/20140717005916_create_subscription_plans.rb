class CreateSubscriptionPlans < ActiveRecord::Migration
  def change
    create_table :subscription_plans do |t|
      t.string :name
      t.string :sku
      t.integer :coffee_grams
      t.boolean :is_active, default: true 

      t.timestamps
    end
  end
end
