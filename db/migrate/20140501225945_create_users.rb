class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.boolean :is_active, default: true
      t.string :is_admin, default: false

      t.timestamps

      t.index :username, unique: true
      t.index :email, unique: true
    end
  end
end
