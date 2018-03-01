class AddAvailableToCities < ActiveRecord::Migration
  def change
    add_column :cities, :is_active, :boolean, default: true
    add_column :communes, :is_active, :boolean, default: true
  end
end
