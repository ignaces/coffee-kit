class AddSubTotalToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :subtotal_price, :decimal
  end
end
