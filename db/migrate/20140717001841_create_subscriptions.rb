class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true
      t.references :subscription_plan, index: true 
      t.references :order, index: true
      t.date :date_from
      t.date :date_to 
      t.integer :months
      t.integer :status

      t.index :status
      t.index :date_from 
      t.index :date_to
      t.index :months

      t.timestamps
    end
  end
end
