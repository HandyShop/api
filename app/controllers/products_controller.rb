class ProductsController < ApplicationController
  before_action :set_market

  # GET /markets/:market_id/products
  def index
    @products = Product.where(market: @market)
    render json: @products
  end

  # GET /markets/:market_id/products/:product_id
  def show
    @product = Product.find_by(market: @market, id: params[:id])
    if @product
      render json: @product
    else
      render status: :not_found
    end
  end

  # POST /markets/:market_id/products
  def create
    @product = Product.new(product_params)
    @market.products << @product

    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /markets/:market_id/products/:product_id
  def update
    @product = Product.find_by(market: @market, id: params[:id])
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /markets/:market_id/products/:product_id
  def destroy
    @product = Product.find_by(market: @market, id: params[:id])
    if @product
      @product.destroy
    else
      render status: :not_found
    end
  end

  private
  def set_market
    @market = Market.find_by_id(params[:market_id])
    if @market.nil?
      render status: :not_found
    end
  end

  def product_params
    params.require(:product).permit(:market_id, :name, :quantity,
                                    :price, :description, :barcode)
  end
end
