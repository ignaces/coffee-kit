class PaypalPayment < Payment

  def payment_request
    payment_request = Paypal::Payment::Request.new(
      :currency_code => :USD,  
      :description   => "Compra en thecoffeekit.com",    
      :quantity      => 1,    
      :amount        => (order.total_price / clp_to_usd).round(2)   # item value
    )
  end

  def self.set_payment(order, notification_url, success_url)
    usd = nil
      request = HTTParty.get('http://www.freecurrencyconverterapi.com/api/convert?q=USD-CLP')
    if request 
      usd = request['results']['USD-CLP']['val']
    end

    payment = PaypalPayment.new(
      currency: 'USD',
      order_id: order.id,
      total: order.total_price,
      clp_to_usd: usd
    )

    response = payment.api.setup(
      payment.payment_request,
      notification_url, 
      success_url, no_shipping: true
    )

    payment.paypal_token = response.token
    payment.save
    return response
  end

  def api
    request = Paypal::Express::Request.new(
      :username   => Rails.application.secrets[:paypal_username],
      :password   => Rails.application.secrets[:paypal_password],
      :signature  => Rails.application.secrets[:paypal_signature]
    )
  end

  def self.total_price_in_usd(price)
    usd = HTTParty.get('http://www.freecurrencyconverterapi.com/api/convert?q=USD-CLP')
    if usd 
      return price / usd['results']['USD-CLP']['val'].to_i
    end
  end



end
