module SubscriptionsHelper

  def coffee_grams_for(coffee_grams)
    return "#{coffee_grams}g" if coffee_grams < 1000
    return "1kg" if coffee_grams == 1000
  end 
end