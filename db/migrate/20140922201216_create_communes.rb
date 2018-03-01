class CreateCommunes < ActiveRecord::Migration
  def change
    create_table :communes do |t|
      t.string :slug
      t.string :name
      t.references :city, index: true
      t.decimal :shipping_price

      t.timestamps
    end
  end
end
