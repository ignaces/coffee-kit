class AddToasterToCoffeeBean < ActiveRecord::Migration
  def change
    add_column :coffee_beans, :toaster, :string
  end
end
