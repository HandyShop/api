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
    render json: @product
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
    @product.destroy
  end

  private
  def set_market
    @market = Market.find(params[:market_id])
  end

  def product_params
    params.require(:product).permit(:market_id, :name, :quantity,
                                    :price, :description, :barcode)
  end
end
