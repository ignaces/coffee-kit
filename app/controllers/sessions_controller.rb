class SessionsController < ApplicationController

  skip_before_action :require_authentication

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or root_path
    else
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

 

  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.digest(User.new_remember_token))
    cookies.delete(:user_remember_token)
    self.current_user = nil
  end

end
