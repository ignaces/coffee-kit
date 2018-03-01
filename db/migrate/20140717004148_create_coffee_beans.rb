class CreateCoffeeBeans < ActiveRecord::Migration
  def change
    create_table :coffee_beans do |t|
      t.string :name
      t.string :sku
      t.string :origin_country
      t.boolean :is_active, default: true
      t.integer :grams_stock, default: 0
      t.integer :grams_package, default: 0

      t.index :is_active
      t.index :grams_stock
      t.index :grams_package
      t.index :origin_country

      t.timestamps
    end
  end
end
