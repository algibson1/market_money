class Api::V0::MarketsController < ApplicationController
  before_action :find_market, only: [:show, :nearest_atms]

  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    render json: MarketSerializer.new(@market)
  end

  def search
    search = MarketSearch.new(search_params)
    if search.valid?
      render json: MarketSerializer.new(Market.search(search))
    else
      render json: ErrorSerializer.invalid_search, status: :unprocessable_entity
    end
  end

  def nearest_atms
    render json: AtmSerializer.new(AtmFacade.atms_for(@market))
  end

  private
  def search_params
    params.permit(:state, :city, :name).to_hash
  end

  def find_market
    begin
      @market = Market.find(params[:id])
    rescue ActiveRecord::RecordNotFound => error
      render json: ErrorSerializer.not_found(error), status: :not_found
    end
  end
end