class ChangeCategoryType < ActiveRecord::Migration
  def change
    remove_column :products, :category
    add_column :products, :category, :integer

    add_index :products, :category
  end
end
