module PaymentsHelper
  def payment_name_for(payment)
    return case payment.type
    when 'PaypalPayment' then 'Paypal'
    when 'KhipuPayment' then 'Khipu'
    end
  end
end
