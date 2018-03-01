class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.integer :status
      t.string :products_ids, array: true, default: []
      t.references :order, index: true
      t.references :shipping_address, index: true
      t.string :shipping_city
      t.string :shipping_town
      t.text :shipping_address
      t.string :shipping_address_number
      t.text :shipping_comments
      t.string :shipping_receiver_name
      t.string :shipping_received_by
      t.datetime :received_at

      t.index :status

      t.timestamps
    end
  end
end
