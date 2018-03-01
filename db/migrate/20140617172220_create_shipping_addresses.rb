class CreateShippingAddresses < ActiveRecord::Migration
  def change
    create_table :shipping_addresses do |t|
      t.integer :user_id
      t.string :city
      t.string :town
      t.text :address
      t.string :address_number
      t.text :comments
      t.string :receiver_name

      t.index :town 
      t.index :user_id

      t.timestamps
    end
  end
end
