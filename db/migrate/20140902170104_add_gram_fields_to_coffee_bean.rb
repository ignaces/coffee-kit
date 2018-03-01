class AddGramFieldsToCoffeeBean < ActiveRecord::Migration
  def change
    add_column :coffee_beans, :available_packages, :string, array: true
  end
end
