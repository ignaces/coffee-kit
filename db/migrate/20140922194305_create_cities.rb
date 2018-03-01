class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :slug
      t.string :name
      t.decimal :shipping_price

      t.timestamps
    end
  end
end
