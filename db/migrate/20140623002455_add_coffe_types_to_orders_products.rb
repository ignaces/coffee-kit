class AddCoffeTypesToOrdersProducts < ActiveRecord::Migration
  def change
    add_column :orders_products, :coffee_types, :string, array: true, default: []
  end
end
