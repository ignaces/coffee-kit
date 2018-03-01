class ChangeColumnToShipment < ActiveRecord::Migration
  def change
    rename_column :shipments, :shipping_address, :shipping_address_address
  end
end
