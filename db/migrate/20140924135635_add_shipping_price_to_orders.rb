class AddShippingPriceToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_price, :decimal, default: 0
  end
end
