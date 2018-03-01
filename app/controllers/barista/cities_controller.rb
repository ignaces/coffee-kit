class Barista::CitiesController < Barista::BaristaController

  before_action :set_city, only: [:show, :edit, :update, :update_commune, :destroy]

  def index
    @cities = City.includes(:communes).order(:slug).all
  end

  def edit
  end

  def update
    if @city.update(city_params)
      flash[:success] = 'Provincia Actualizada'
      redirect_to action: :edit
    else
      render :edit
    end
  end

  def update_commune
    @commune = @city.communes.find(params[:commune][:id]) 
    
    if @commune.update(commune_params)
      flash[:success] = 'Comuna actualizada'
      redirect_to action: :edit
    else
      render :edit
    end
  end

  private

    def set_city
      @city = City.includes(:communes).find_by(slug: params[:id])
    end

    def city_params
      params.require(:city).permit(:is_active, :shipping_price)
    end

    def commune_params
      params.require(:commune).permit(:is_active, :shipping_price)
    end

end