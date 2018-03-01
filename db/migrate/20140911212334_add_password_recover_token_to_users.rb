class AddPasswordRecoverTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_recovery_token, :string
    add_index :users, :password_recovery_token
  end
end
