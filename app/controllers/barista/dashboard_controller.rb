class Barista::DashboardController < Barista::BaristaController

  def index
    @date_from = params[:date_from].present? ? params[:date_from].to_date : Date.today.beginning_of_month
    @date_to = params[:date_to].present? ? params[:date_to].to_date : Date.today

    @total_users = User.where(created_at: @date_from..@date_to).count
    @total_revenue = Order.completed.where(completed_at: @date_from..@date_to).sum(:total_price).round
    @total_orders = Order.completed.where(completed_at: @date_from..@date_to).count
    @total_subscriptions = Subscription.active.joins(:order).where('orders.completed_at >= ?', @date_from)
                                                            .where('orders.completed_at <= ?', @date_to).count

  end


end