class AddCommuneToShippingAddress < ActiveRecord::Migration
  def change
    add_reference :shipping_addresses, :commune, index: true
  end
end
