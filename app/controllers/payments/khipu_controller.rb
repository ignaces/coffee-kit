class Payments::KhipuController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :require_authentication

  def verify
    payment = KhipuPayment.verify_payment(params)
    render nothing: true, status: 200
  end
end
