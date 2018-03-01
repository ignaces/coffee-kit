class AddAddressNumber2ToShipments < ActiveRecord::Migration
  def change
    add_column :shipments, :shipping_address_number_2, :string
  end
end
