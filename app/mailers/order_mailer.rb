class OrderMailer < ActionMailer::Base
  default from: "The Coffee Kit <hola@thecoffeekit.com>"

  def confirmation(order)
    @order = order 
    mail(to: @order.user.email, subject: 'Confirmación de compra')
  end
end
