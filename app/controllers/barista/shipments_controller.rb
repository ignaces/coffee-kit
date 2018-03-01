class Barista::ShipmentsController < Barista::BaristaController

  def index
    @shipments = Shipment.includes({order: [{items: :product}, {subscription: :subscription_plan}, :user]}, {subscription_month: :coffee_bean_selections}).order('shipping_date DESC').page(params[:page])

    if params[:period] == 'current_week'
      @shipments = @shipments.where(shipping_date: Date.today.beginning_of_week..Date.today.end_of_week)
    elsif params[:period] == 'next_week'
      @shipments = @shipments.where(shipping_date: 1.week.from_now.beginning_of_week..1.week.from_now.end_of_week)
    end

  end

  def show
    @shipment = Shipment.find(params[:id])
    @order = @shipment.order 
    @subscription_month = @shipment.subscription_month
  end

  def update_status
    @shipment = Shipment.find(params[:id])
    @shipment.status = params[:status]
    @shipment.save 
    redirect_to barista_shipments_path
  end
end
