class Coupon < ActiveRecord::Base

  has_many :orders

  def can_activate?
    activations < allowed_activations
  end

  def apply_discount(order)
    order.subtotal_price = order.subtotal_price * (100 - discount) / 100
  end

  def apply_activation
    update(activations: activations - 1) if can_activate?
  end

  def redeem(order)
    subtotal = order.subtotal_price * (100 - discount) / 100
    order.update_attributes(coupon_id: id, subtotal_price: subtotal)
  end




end
