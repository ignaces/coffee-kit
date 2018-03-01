module CoffeeBeansHelper

  def full_coffee_bean_name_for(coffee_bean)
    quantity = coffee_bean.grams_package < 1000 ? "#{coffee_bean.grams_package} G" : "#{coffee_bean.grams_package/1000} K"
    "#{quantity} de #{coffee_bean.name}"
  end
end
