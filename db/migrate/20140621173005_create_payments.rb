class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :type
      t.string :currency
      t.integer :status
      t.string :paypal_token
      t.string :paypal_payer_id
      t.string :paypal_transaction_id
      t.string :khipu_transaction_id
      t.string :khipu_url
      t.decimal :clp_to_usd
      t.decimal :total
      t.decimal :tax
      t.references :order, index: true

      t.index :status
      t.index :type

      t.timestamps
    end
  end
end
