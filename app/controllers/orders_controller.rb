class OrdersController < ApplicationController
  include SubscriptionsHelper

  before_action :require_authentication, only: [:shipping, :update_shipping, :checkout, :pay_with_paypal, :pay_with_khipu]
  before_action :require_current_order, except: [:add_to_cart, :add_subscription, :success]

  layout 'checkout'

  def cart
  end

  def add_subscription 
    set_current_order if current_order.nil?
    current_order.add_or_update_subscription(SubscriptionPlan.find_by(sku: params[:plan] || 'PLAN-500G').id, params[:months] || 6)
    redirect_to pricing_order_path(current_order, plan: 'PLAN-500G')
  end

  def pricing
    current_order.add_or_update_subscription(SubscriptionPlan.find_by(sku: params[:plan] || 'PLAN-500G').id, params[:months] || 6)
    @subscription = current_order.subscription
    @plan = @subscription.subscription_plan
    @entries = @plan.entries
  end

  def update_pricing
    if params[:months].to_i < 1 || params[:months].to_i > 12
      flash.now[:error] = 'La cantidad de meses debe ser de 1 a 12'
      render :pricing 
      return
    end
    current_order.add_or_update_subscription(SubscriptionPlan.find_by(sku: params[:plan] || 'PLAN-500G').id, params[:months] || 6)
    current_order.update_attributes(user_id: current_user.id) if current_user
    redirect_to coffee_order_path(current_order)
  end

  def coffee
    @subscription = current_order.subscription
    current_order.update_attributes(user_id: current_user.id) if current_user
  end 

  def update_coffee
    @subscription = current_order.subscription
    @plan = @subscription.subscription_plan

    #validate selected grams
 
    unless params[:beans]
      flash.now[:notice] = "Para continuar, debes seleccionar #{coffee_grams_for(@plan.coffee_grams)} de café"
      render :coffee
      return
    end

    selected_grams = params[:beans].map{ |b| b[:grams].to_i }.sum
    
    if selected_grams != @plan.coffee_grams
      flash.now[:notice] = "Para continuar, debes seleccionar #{coffee_grams_for(@plan.coffee_grams)} de café"
      render :coffee
      return
    end

    subscription_month = @subscription.subscription_months.first 
    subscription_month = @subscription.subscription_months.create unless subscription_month

    if subscription_month.select_beans(params[:beans])
      redirect_to shipping_order_path(current_order.uuid)
    else
      flash[:error] = 'Ocurrió un error al seleccionar tu café'
      render :coffee
    end

  end

  def shipping
    current_order.update_attributes(user_id: current_user.id) if current_user && !current_order.user_id
    if current_user.shipping_addresses.any?
      @shipping = current_user.shipping_addresses.first
    else
      @shipping = current_user.shipping_addresses.new
    end
  end

  def update_shipping
    current_order.update_attributes(user_id: current_user.id) if current_user && !current_order.user_id
    if params[:shipping_id].present?
      @shipping = current_user.shipping_addresses.find(params[:shipping_id])
      if @shipping.update_attributes(shipping_params)
        current_order.update_attribute(:shipping_address_id, @shipping.id)
        current_order.update_total_price
        redirect_to checkout_order_path(current_order)
      else
        render :shipping 
      end
    else
      @shipping = current_user.shipping_addresses.new(shipping_params)
      if @shipping.save
        current_order.update_attribute(:shipping_address_id, @shipping.id)
        current_order.update_total_price
        redirect_to checkout_order_path(current_order)
      else
        render :shipping 
      end
    end
  end

  def checkout
    if current_order.subscription && current_order.subscription.subscription_months.empty?
      redirect_to coffee_order_path(current_order) 
      return
    end

    if !current_order.shipping_address
      redirect_to shipping_order_path(current_order) 
      return
    end

    if !current_order.subscription && current_order.items.empty?
      redirect_to root_path
      return
    end

    if !current_order.shipping_address
      redirect_to shipping_order_path(current_order.uuid)
      return
    end

    current_order.update_attributes(user_id: current_user.id) if current_user
    @subscription = current_order.subscription 
    @first_month = @subscription.subscription_months.first if @subscription
    
  end

  def add_to_cart
    set_current_order if current_order.nil?
    current_order.add_or_update_product(Product.find_by(sku: params[:sku]), 1)
    redirect_to cart_orders_path
  end

  def remove_from_cart
    current_order.remove_product(params[:product_id])
    redirect_to cart_orders_path
  end

  def remove_subscription_from_cart
    current_order.subscription.destroy if current_order.subscription 
    current_order.update_total_price
    redirect_to cart_orders_path
  end

  def update_product_quantity
    if params[:quantity].try(:to_i) < 1
      flash[:error] = 'Nop, todavía no encontramos la forma de vender cantidades negativas :)'
      redirect_to cart_orders_path
    end

    current_order.add_or_update_product(params[:product_id], params[:quantity])
    redirect_to cart_orders_path
  end

  def redeem_code
    coupon = Coupon.find_by(code: params[:code].try(:upcase))
    if coupon && coupon.can_activate?
      coupon.redeem(current_order) 
    end
    redirect_to checkout_order_path(current_order)
  end

  def pay_with_khipu
    payment = KhipuPayment.set_payment(current_order)
    unset_current_order
    redirect_to payment.khipu_url
  end

  def pay_with_paypal
    payment = PaypalPayment.set_payment(current_order, payments_paypal_verification_url, root_url)
    unset_current_order
    redirect_to payment.redirect_uri.concat("&useraction=commit")
  end

  private

  def require_current_order
    redirect_to root_path unless current_order
  end

  def shipping_params
    params.require(:shipping_address).permit(:commune_id, :address, :address_number, :contact_phone)
  end

  def set_current_order
    unless current_order
      remember_token = Order.new_remember_token
      cookies.permanent[:order_remember_token] = remember_token
      current_order = Order.create(remember_token: Order.digest(remember_token), user: current_user)
    end
  end

  def unset_current_order
    cookies.delete :order_remember_token
  end

end