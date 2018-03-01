# == Schema Information
#
# Table name: shipments
#
#  id                      :integer          not null, primary key
#  status                  :integer
#  products_ids            :string(255)      default([]), is an Array
#  order_id                :integer
#  shipping_address_id     :integer
#  shipping_city           :string(255)
#  shipping_town           :string(255)
#  shipping_address        :text
#  shipping_address_number :string(255)
#  shipping_comments       :text
#  shipping_receiver_name  :string(255)
#  shipping_received_by    :string(255)
#  received_at             :datetime
#  created_at              :datetime
#  updated_at              :datetime
#

class Shipment < ActiveRecord::Base
  enum status: [:pending, :preparing, :route, :delivered]

  belongs_to :shipping_address
  belongs_to :order
  has_one :subscription_month

  before_create :set_defaults

  def full_address
    full_address = "#{shipping_address_address.titleize}"
    full_address << ", #{shipping_address_number_2}" if shipping_address_number_2
    full_address << ", #{shipping_town}" if shipping_town
    full_address << ", #{shipping_city}" if shipping_city
    full_address
  end

  def self.create_for_order(order)
    first_shipment = order.shipments.new 
    first_shipment.products_ids = order.items.map(&:id) if order.items.any?
    first_shipment.shipping_date = 5.weekdays_from_now.to_date
    first_shipment.save!

    if order.subscription
      order.subscription.status = Subscription.statuses[:active]
      order.subscription.user_id = order.user_id
      first_subscription_month = order.subscription.subscription_months.order('month ASC').first
      first_subscription_month.shipment_id = first_shipment.id 
      first_subscription_month.save 
      order.subscription.save

      order.subscription.subscription_months.first.update(month: 5.weekdays_from_now.beginning_of_month.to_date)

      current_month = 1

      (order.subscription.months - 1).times do

        shipment = order.shipments.create!(
          shipping_date: 5.weekdays_from(current_month.months.from_now.to_date).to_date
        )

        order.subscription.subscription_months.create!(
          month: shipment.shipping_date.beginning_of_month,
          shipment_id: shipment.id 
        )

        current_month += 1
      end
    end
  end

  private

  def set_defaults
    self.status = Shipment.statuses[:pending]
    self.shipping_address_id = order.shipping_address_id 
    self.shipping_city = order.shipping_address.commune.city.name
    self.shipping_town = order.shipping_address.commune.name 
    self.shipping_address_address = order.shipping_address.address 
    self.shipping_address_number_2 = order.shipping_address.address_number_2
    self.shipping_comments = order.shipping_address.comments
  end
end
