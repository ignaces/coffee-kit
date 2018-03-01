class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_authentication, only: [:dashboard]
  before_action :require_active_subscription, only: [:dashboard]

  def dashboard
    @subscription = current_user.active_subscription
    @months = @subscription.subscription_months
    @current_month = @months.where(month: Date.today.beginning_of_month.to_date).first || @months.first
    @plan = @subscription.subscription_plan
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      redirect_back_or root_path 
    else 
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def require_active_subscription
      redirect_to root_path unless current_user.active_subscription
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :first_name, :last_name)
    end
end
