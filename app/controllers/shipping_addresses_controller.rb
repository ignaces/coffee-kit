class ShippingAddressesController < ApplicationController

  def new
    @address = current_user.shipping_addresses.new
  end

  def create
    @address = current_user.shipping_addresses.new(shipping_address_params)
    if @address.save 
      redirect_to cart_order_path(current_order.uuid)
    else
      render :new
    end
  end

  def load_communes
    @communes = Commune.order(:slug).where(is_active: true, city_id: params[:city_id])
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = curren_user.shipping_addresses.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipping_address_params
      params.require(:shipping_address).permit(:commune_id, :address, :address_number_2, :comments, :contact_phone)
    end

end
