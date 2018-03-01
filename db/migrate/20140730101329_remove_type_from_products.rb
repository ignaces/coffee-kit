class RemoveTypeFromProducts < ActiveRecord::Migration
  def change
    drop_table :reservations
    drop_table :delayed_jobs
    remove_column :products, :type 
    remove_column :products, :suscription_months
    remove_column :products, :suscription_coffee_grams
  end
end
