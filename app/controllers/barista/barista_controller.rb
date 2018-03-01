class Barista::BaristaController < ApplicationController
  before_action :require_authentication
  before_action :require_admin


  layout 'barista'

  def require_admin
    redirect_to signin_path unless current_user.is_admin?
  end

  def index
  end

  
end