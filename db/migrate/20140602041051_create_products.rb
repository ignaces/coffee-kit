class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :sku
      t.string :name 
      t.text :description
      t.string :category
      t.decimal :buy_price
      t.decimal :sell_price
      t.boolean :is_active
      t.integer :stock
      t.string :photo_1
      t.string :photo_2
      t.string :photo_3
      t.string :photo_4
      t.string :photo_5
      t.string :main_photo

      t.index :sku
      t.index :name
      t.index :category
      t.index :buy_price
      t.index :sell_price
      t.index :stock

      t.timestamps
    end
  end
end
