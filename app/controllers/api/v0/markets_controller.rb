class Api::V0::MarketsController < ApplicationController
  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    begin
      market = Market.find(params[:id])
      render json: MarketSerializer.new(market)
    rescue ActiveRecord::RecordNotFound => error
      # render json: ErrorMarketSerializer.format_error(error)
      render json: { errors: [{detail: error.message}] }, status: :not_found
    end
  end
end