class Payments::PaypalController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :require_authentication


  def verify
    payment = PaypalPayment.find_by(paypal_token: params[:token])
    logger.info(params);
    if payment
      response = payment.api.checkout!(params['token'], params['PayerID'], payment.payment_request)
      logger.info(response)
      logger.info(response.payment_info)
      if response.payment_info.first.payment_status == 'Completed'

        payment.paypal_transaction_id = response.payment_info.first.transaction_id
        payment.save
        payment.complete!
        redirect_to success_orders_path
      end
    end
    
  end



end
