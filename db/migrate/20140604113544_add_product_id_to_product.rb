class AddProductIdToProduct < ActiveRecord::Migration
  def change
    add_column :products, :parent_product_id, :integer
    add_index :products, :parent_product_id
  end
end
