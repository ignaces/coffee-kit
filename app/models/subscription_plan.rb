class SubscriptionPlan < ActiveRecord::Base

  has_many :entries, class_name: 'SubscriptionPlanEntry'

end
