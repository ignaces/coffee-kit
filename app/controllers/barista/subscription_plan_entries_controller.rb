class Barista::SubscriptionPlanEntriesController < Barista::BaristaController

  before_action :set_plan
  before_action :set_entry, only: [:show, :edit, :update, :destroy]


  def create
    @plan.entries.create(entry_params)
    redirect_to edit_barista_subscription_plan_path(@plan)
  end

  def edit
  end

  def update
    @entry.update(entry_params)
    redirect_to edit_barista_subscription_plan_path(@plan)
  end

  def destroy
    @entry.destroy
    redirect_to edit_barista_subscription_plan_path(@plan)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = SubscriptionPlan.find(params[:subscription_plan_id])
    end

    def set_entry
      @entry = @plan.entries.find(params[:id])
    end

    def entry_params
      params.require(:subscription_plan_entry).permit(:period_quantity, 
                                                      :price)
    end

end
