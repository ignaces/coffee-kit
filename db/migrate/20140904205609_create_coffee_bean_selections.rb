class CreateCoffeeBeanSelections < ActiveRecord::Migration
  def change
    create_table :coffee_bean_selections do |t|
      t.references :coffee_bean 
      t.references :subscription_month
      t.integer :grams

      t.timestamps
    end
  end
end
