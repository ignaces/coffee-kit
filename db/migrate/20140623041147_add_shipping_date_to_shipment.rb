class AddShippingDateToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :shipping_date, :date
  end
end
