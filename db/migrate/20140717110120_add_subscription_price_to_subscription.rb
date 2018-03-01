class AddSubscriptionPriceToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :subscription_plan_price, :decimal
  end
end
