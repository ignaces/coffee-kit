class AddTokensToOrdersAndProducts < ActiveRecord::Migration
  def change
    add_column :products, :uuid, :string
    add_column :orders, :uuid, :string

    add_index :products, :uuid, unique: true
    add_index :orders, :uuid, unique: true
  end
end
