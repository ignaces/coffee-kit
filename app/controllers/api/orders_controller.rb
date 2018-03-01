class Api::OrdersController < Api::ApiController

  def total_revenue
    date_from = params[:date_from].present? ? params[:date_from].to_date : Date.today.beginning_of_month
    date_to = params[:date_to].present? ? params[:date_to].to_date : Date.today

    grouper = date_from < (date_to - 1.month) ? '%m-%Y' : '%d-%m-%Y'

    orders = Order.completed.where(completed_at: date_from..date_to).order('completed_at').pluck(:completed_at, :total_price)
    orders = orders.group_by { |order| order.first.strftime(grouper) }
    orders = orders.map { |order| { date: order[0], revenue: order[1].inject(0){ |sum, n| sum + n[1].round.to_i } } }

    render json: orders
  end

end
