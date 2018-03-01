class CreateOrdersProducts < ActiveRecord::Migration
  def change
    create_table :orders_products do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :quantity
      t.decimal :product_price
      t.decimal :total_price

      t.index :order_id
      t.index :product_id
      t.index [:order_id, :product_id], unique: true
      t.timestamps  
    end
  end
end
