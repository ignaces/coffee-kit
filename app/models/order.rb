# == Schema Information
#
# Table name: orders
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  payment_id     :integer
#  status         :integer
#  total_price    :decimal(, )
#  created_at     :datetime
#  updated_at     :datetime
#  remember_token :string(255)
#

class Order < ActiveRecord::Base
  enum status: [:pricing, :coffee, :shipping, :cart, :checkout, :canceled, :failed, :completed]

  belongs_to :user
  has_many :items, class_name: 'OrdersProducts', dependent: :delete_all
  has_many :products
  has_one :subscription, dependent: :destroy
  has_and_belongs_to_many :subscriptions, -> { where("products.type = ?", 'SubscriptionProduct') }, class_name: 'Product'
  has_many :shipments, dependent: :delete_all
  has_one :payment, dependent: :delete
  belongs_to :coupon
  belongs_to :shipping_address

  before_create :set_defaults


  def add_or_update_product(product_id, quantity)
    product = Product.find(product_id)

    if product
      item = items.find_by(product_id: product.id)

      if item
        item.update_attribute(:quantity, quantity)
      else
        items.create(product_id: product.id, product_price: product.sell_price, quantity: quantity)
      end
    else
      false
    end

    update_total_price
  end

  def add_or_update_subscription(subscription_plan_id, months)
    subscription_plan = SubscriptionPlan.find(subscription_plan_id)

    if subscription_plan
      if subscription
        subscription.update_attributes(months: months, subscription_plan_id: subscription_plan_id)
      else
        create_subscription(months: months, subscription_plan_id: subscription_plan_id)
      end
    else
      return false
    end

    update_total_price
  end

  def remove_product(product_id)
    items.find_by(product_id: product_id).destroy
    update_total_price
  end

  def update_total_price
    subtotal_price = items.reload.map{ |item| item.product_price.to_i * item.quantity }
    subtotal_price = subtotal_price.inject(:+) || 0

    reload
    
    if subscription
      #calculate shipping price
      if shipping_address && shipping_address.commune
        update(shipping_price: shipping_address.commune.shipping_price * subscription.months)
      end

      subtotal_price ||= 0
      subscription_price = subscription.subscription_plan.entries.find_by(period_quantity: subscription.months).price
      subtotal_price += subscription_price
      subscription.update_attribute(:subscription_plan_price, subscription_price)
    else
      update(shipping_price: 0)
    end

    coupon.apply_discount(self) if coupon
    update(subtotal_price: subtotal_price || 0, total_price: (subtotal_price + shipping_price))
  end

 
  def complete!
    ActiveRecord::Base.transaction do 
      unless completed?
        update_attributes status: Order.statuses[:completed], completed_at: Time.now
        coupon.apply_activation if coupon
        Shipment.create_for_order(self)
        send_confirmation_email
      end
    end
  end

  def fail!
    update_attribute :status, Order.statuses[:failed]
  end

  def send_confirmation_email
    unless confirmation_email_sent_at
      OrderMailer.confirmation(self).deliver 
      update confirmation_email_sent_at: Time.now
    end
  rescue
  end

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def to_param
    uuid
  end

  private 

    def set_defaults 
      self.status = Order.statuses[:cart]
      begin
        self.uuid = SecureRandom.hex(4).upcase
      end while Order.exists?(uuid: uuid)
    end

end
