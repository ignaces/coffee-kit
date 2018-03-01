class Barista::ProductsController < Barista::BaristaController

  before_action :set_product, only: [:show, :edit, :update, :destroy]
  
  
  def index
    @products = Product.order(:name).page(params[:page])
  end

  def new 
    @product = Product.new
  end

  def edit

  end

  def update
    if @product.update(product_params)
      redirect_to action: :index 
    else
      render :edit
    end
  end

  def show
  end

  def create 
    @product = Product.new(product_params)
    if @product.save 
      redirect_to action: :index, notice: 'Producto creado'
    else
      render :new
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:sku, 
                                      :name, 
                                      :description,
                                      :buy_price,
                                      :sell_price,
                                      :is_active,
                                      :stock, 
                                      :photo_1, 
                                      :tag_list)
    end
end
