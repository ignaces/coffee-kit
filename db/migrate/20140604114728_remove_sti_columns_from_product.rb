class RemoveStiColumnsFromProduct < ActiveRecord::Migration
  def change
    remove_column :products, :type 
    remove_column :products, :parent_product_id
  end
end
