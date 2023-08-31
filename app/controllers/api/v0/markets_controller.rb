class Api::V0::MarketsController < ApplicationController
  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    begin
      market = Market.find(params[:id])
      render json: MarketSerializer.new(market)
    rescue ActiveRecord::RecordNotFound => error
      render json: ErrorSerializer.not_found(error), status: :not_found
    end
  end

  def search
    search = MarketSearch.new(search_params)
    if search.valid?
      render json: MarketSerializer.new(Market.search(search))
    else
      render json: ErrorSerializer.invalid_search, status: :unprocessable_entity
    end
  end

  private
  def search_params
    params.permit(:state, :city, :name).to_hash
  end
end