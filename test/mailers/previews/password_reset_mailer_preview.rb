class PasswordResetMailerPreview < ActionMailer::Preview

  def reset_password
    PasswordResetMailer.reset_password(User.first)
  end

end