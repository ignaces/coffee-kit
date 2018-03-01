class SubscriptionsController < ApplicationController
  include SubscriptionsHelper

  before_action :require_authentication
  before_action :require_active_subscription
  before_action :set_subscription

  def show
    redirect_to month_subscription_path(date: Date.today.strftime('%m-%Y'))
  end

  def show_month
    @month = @subscription.subscription_months.includes(:coffee_beans).find_by(month: Date.strptime(params[:date], "%m-%Y").beginning_of_month)
    redirect_to month_subscription_path(date: @subscription.subscription_months.last.month.strftime('%m-%Y')) unless @month
  end

  # PUT /subscription/month/:date/select_month_beans

  def select_month_beans
    @month = @subscription.subscription_months.includes(:coffee_beans).find_by(month: Date.strptime(params[:date], "%m-%Y").beginning_of_month)
    #validate selected beans
 
    unless params[:beans]
      flash.now[:notice] = "Para continuar, debes seleccionar #{coffee_grams_for(@plan.coffee_grams)} de café"
      render :show_month
      return
    end

    selected_grams = params[:beans].map{ |b| b[:grams].to_i }.sum

    if selected_grams != @plan.coffee_grams
      flash.now[:notice] = "Para continuar, debes seleccionar #{coffee_grams_for(@plan.coffee_grams)} de café"
      render :show_month
      return
    end

    if @month.select_beans(params[:beans])
      flash[:notice] = '¡Tu café fue seleccionado!'
      redirect_to month_subscription_path(@month.month.strftime('%m-%Y'))
    else
      flash[:error] = 'Ocurrió un error al seleccionar tu café'
      render :show_month
    end
  end

  private
    
    def require_active_subscription
      redirect_to root_path unless current_user.active_subscription
    end

    def set_subscription
      @subscription = current_user.active_subscription
      @plan = @subscription.subscription_plan
    end

end