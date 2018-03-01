class Barista::CoffeeBeansController < Barista::BaristaController
  before_action :set_coffee_bean, only: [:show, :edit, :update, :destroy]

  def index
    @beans = CoffeeBean.all
  end

  # GET /coffee_beans/1
  # GET /coffee_beans/1.json
  def show
  end

  # GET /coffee_beans/new
  def new
    @bean = CoffeeBean.new
  end

  # GET /coffee_beans/1/edit
  def edit
  end

  # POST /coffee_beans
  # POST /coffee_beans.json
  def create
    @bean = CoffeeBean.new(coffee_bean_params)
   
    if @bean.save
      redirect_to action: :index 
    else
      render :new
    end
  end

  # PATCH/PUT /coffee_beans/1
  # PATCH/PUT /coffee_beans/1.json
  def update
    if @bean.update(coffee_bean_params)
      redirect_to action: :edit
    else 
      render :edit
    end
  end

  # DELETE /coffee_beans/1
  # DELETE /coffee_beans/1.json
  def destroy
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coffee_bean
      @bean = CoffeeBean.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coffee_bean_params
      params.require(:coffee_bean).permit(:sku, 
                                   :name, 
                                   :origin_country,
                                   :toaster,
                                   :available_packages,
                                   :grams_stock,
                                   :is_active)
    end    
end
