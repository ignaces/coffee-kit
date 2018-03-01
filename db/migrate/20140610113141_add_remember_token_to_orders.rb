class AddRememberTokenToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :remember_token, :string
    add_index :orders, :remember_token
  end
end
