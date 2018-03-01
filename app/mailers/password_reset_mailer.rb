class PasswordResetMailer < ActionMailer::Base
  default from: "The Coffee Kit <hola@thecoffeekit.com>"

  def reset_password(user)
    @user = user 
    mail(to: @user.email, subject: 'Recupera tu contraseña')
  end
end
