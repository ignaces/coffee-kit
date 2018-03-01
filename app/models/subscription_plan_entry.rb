class SubscriptionPlanEntry < ActiveRecord::Base

  validates :period_quantity, uniqueness: { scope: :subscription_plan_id }

end
