class AddAdresssNumber2ToShippingAddresses < ActiveRecord::Migration
  def change
    add_column :shipping_addresses, :address_number_2, :string
  end
end
