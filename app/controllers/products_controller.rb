class ProductsController < ApplicationController
  before_action :set_market

  # GET /markets/:market_id/products
  def index
    if @market
      @products = Product.where(market: @market)
      render json: @products
    else
      render status: :not_found
    end
  end

  # GET /markets/:market_id/products/:product_id
  def show
    if @market
      @product = Product.find_by(market: @market, id: params[:id])
      if @product
        render json: @product
      else
        render status: :not_found
      end
    else
      render status: :not_found
    end
  end

  # POST /markets/:market_id/products
  def create
    if @market
      @product = Product.new(product_params)
      @market.products << @product

      if @product.save
        render json: @product, status: :created
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    else
      render status: :not_found
    end
  end

  # PATCH/PUT /markets/:market_id/products/:product_id
  def update
    if @market
      @product = Product.find_by(market: @market, id: params[:id])
      if @product.update(product_params)
        render json: @product
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    else
      render status: :not_found
    end
  end

  # DELETE /markets/:market_id/products/:product_id
  def destroy
    if @market
      @product = Product.find_by(market: @market, id: params[:id])
      if @product
        @product.destroy
      else
        render status: :not_found
      end
    else
      render status: :not_found
    end
  end

  private
  def set_market
    @market = Market.find_by_id(params[:market_id])
  end

  def product_params
    params.require(:product).permit(:market_id, :name, :quantity,
                                    :price, :description, :barcode)
  end
end
