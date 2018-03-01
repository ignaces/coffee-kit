class SubscriptionMonth < ActiveRecord::Base

  belongs_to :subscription
  belongs_to :shipment
  has_many :coffee_bean_selections, dependent: :delete_all
  has_many :coffee_beans, through: :coffee_bean_selections

  def select_beans(beans)
    ActiveRecord::Base.transaction do 
      coffee_bean_selections.delete_all

      beans.each do |bean|
        new_bean = CoffeeBean.find_by(is_active: true, sku: bean[:sku])
        return false unless new_bean
        coffee_bean_selections.create(coffee_bean_id: new_bean.id, grams: bean[:grams].to_i)
      end

    end
    true
  end

end
