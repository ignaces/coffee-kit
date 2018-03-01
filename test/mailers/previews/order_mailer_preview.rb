class OrderMailerPreview < ActionMailer::Preview

  def confirmation
    OrderMailer.confirmation(Order.completed.last)
  end

end