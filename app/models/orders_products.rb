# == Schema Information
#
# Table name: orders_products
#
#  id            :integer          not null, primary key
#  order_id      :integer
#  product_id    :integer
#  quantity      :integer
#  product_price :decimal(, )
#  total_price   :decimal(, )
#  created_at    :datetime
#  updated_at    :datetime
#

class OrdersProducts < ActiveRecord::Base
  belongs_to :order 
  belongs_to :product
end
