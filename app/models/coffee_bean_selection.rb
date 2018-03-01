class CoffeeBeanSelection < ActiveRecord::Base

  belongs_to :coffee_bean
  belongs_to :subscription_month

end
