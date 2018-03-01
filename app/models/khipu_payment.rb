class KhipuPayment < Payment

  before_create :set_defaults

  def self.set_payment(order)    
    order_total = order.total_price.to_i

    payment_params = {
      subject: 'Compra en thecoffeekit.com',
      amount: order_total,
      email: order.user.email,
      notify_url: 'http://thecoffeekit.com/payments/khipu_verification', 
      return_url: 'http://thecoffeekit.com/orders/khipu_success'
    }

    payment_hash = api.create_payment_url(payment_params)

    KhipuPayment.create!(
      currency: 'CLP',
      order_id: order.id,
      total: order_total,
      tax: (order_total * 0.01) > 200 ? 200 : (order_total * 0.01),
      khipu_transaction_id: payment_hash['id'],
      khipu_url: payment_hash['url']
    )
  end

  def self.verify_payment(payment_params)
    payment = KhipuPayment.find_by(khipu_transaction_id: payment_params['notification_id']) 
    if payment
      verification_hash = Hash[ payment_params.map{ |k,v| [k.to_sym, v.to_s] } ]
      if api.verify_payment_notification(verification_hash)
        payment.complete!
      else
        payment.fail!
        return false
      end
    else
      false
    end
  end

  def self.api
    Khipu.create_khipu_api(Rails.application.secrets[:khipu_id], Rails.application.secrets[:khipu_secret])    
  end 

  private

    def set_defaults
      self.status = Payment.statuses[:pending]
    end

end