class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :activations, default: 0
      t.integer :allowed_activations, default: 1
      t.integer :discount

      t.timestamps
    end

    add_column :orders, :coupon_id, :integer
    add_index :orders, :coupon_id
  end
end
