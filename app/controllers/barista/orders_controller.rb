class Barista::OrdersController < Barista::BaristaController

  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.includes(:user, :coupon).completed.order(completed_at: :desc).page(params[:page])
  end

  def show
  end

  private

    def set_order
      @order = Order.includes(items: :product).find_by(uuid: params[:id])
    end



end
