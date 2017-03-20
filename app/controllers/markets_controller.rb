class MarketsController < ApplicationController
  before_action :set_market, only: [:show, :update]

  # GET /markets
  def index
    @markets = Market.all
    render json: @markets
  end

  # GET /markets/1
  def show
    render json: @market
  end

  # POST /markets
  def create
    @market = Market.new(market_params)

    if @market.save
      render json: @market, status: :created, location: @market
    else
      render json: @market.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /markets/1
  def update
    if @market.update(market_params)
      render json: @market
    else
      render json: @market.errors, status: :unprocessable_entity
    end
  end

  # DELETE /markets/1
  def destroy
    @market = Market.find_by_id(params[:id])
    if @market
      @market.destroy
    else
      render status: :not_found
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_market
    @market = Market.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def market_params
    params.require(:market).permit(:name)
  end
end
