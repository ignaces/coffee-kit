class Barista::SubscriptionPlansController < Barista::BaristaController

  before_action :set_plan, only: [:show, :edit, :update, :destroy, :create_entry]

  def index
    @plans = SubscriptionPlan.all
  end

  def new
    @plan = SubscriptionPlan.new
  end

  def create
    @plan = SubscriptionPlan.new(plan_params)
    if @plan.save
      redirect_to action: :edit 
    else
      render :new
    end
  end

  def update
    if @plan.update(plan_params)
      redirect_to action: :edit
    else 
      render :edit
    end
  end

  def create_entry

  end

  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = SubscriptionPlan.find(params[:id])
    end

    def plan_params
      params.require(:subscription_plan).permit(:sku, 
                                   :name, 
                                   :coffee_grams,
                                   :is_active)
    end

end
