class AddNewFieldToOrder < ActiveRecord::Migration
  def change
    add_column :products, :type, :string
    add_column :products, :suscription_months, :integer
    add_column :products, :suscription_coffee_grams, :integer
  end
end
