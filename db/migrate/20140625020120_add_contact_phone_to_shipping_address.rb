class AddContactPhoneToShippingAddress < ActiveRecord::Migration
  def change
    add_column :shipping_addresses, :contact_phone, :string
  end
end
