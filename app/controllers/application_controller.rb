class ApplicationController < ActionController::Base
  #Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  rescue_from ActionController::RoutingError, :with => :redirect_missing
  rescue_from ActionController::UnknownController, :with => :redirect_missing

  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :current_user?
  helper_method :current_order

  before_bugsnag_notify :add_user_info_to_bugsnag

  def require_authentication
    unless current_user
      store_location
      flash[:notice] = 'Inicia sesión para continuar'
      redirect_to signin_path 
    end
  end

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:user_remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end

  def current_user
    @current_user ||= User.find_by(remember_token: User.digest(cookies[:user_remember_token]))
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user?(user)
    user == current_user
  end

  def current_order 
    @current_order ||= Order.find_by(remember_token: Order.digest(cookies[:order_remember_token]))
  end

  def current_order=(order)
    @current_order = order 
  end
    
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  protected

  def redirect_missing
    redirect_to root_path
    return
  end

  def add_user_info_to_bugsnag(notif)
    if current_user
      notif.user = {
        email: current_user.email,
        name: current_user.first_name,
        id: current_user.id
      }
    end
  end

end
