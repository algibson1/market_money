class Api::V0::MarketVendorsController < ApplicationController
  def index
    begin
      market = Market.find(params[:market_id])
      render json: VendorSerializer.new(market.vendors)
    rescue ActiveRecord::RecordNotFound => error
      render json: ErrorSerializer.format_error(error), status: :not_found
    end
  end

end