class ProductsController < ApplicationController
  
  def index 
    @products = Product.where(is_active: true).all
  end

  def show
    @product = Product.friendly.find(params[:id])
    @related_products = Product.tagged_with(@product.tag_list, any: true).where.not(id: @product.id).order('sell_price ASC').limit(3)
  end

end