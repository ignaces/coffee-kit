class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :payment_id 
      t.integer :status
      t.decimal :total_price

      t.index :user_id
      t.index :payment_id
      t.index :status
      t.decimal :total_price
      t.timestamps
    end
  end
end
