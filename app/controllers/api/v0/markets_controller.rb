class Api::V0::MarketsController < ApplicationController
  def index
    render json: {data: MarketSerializer.format_markets(Market.all)}
  end

  def show

  end
end