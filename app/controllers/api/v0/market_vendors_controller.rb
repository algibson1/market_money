class Api::V0::MarketVendorsController < ApplicationController
  def index
    begin
      market = Market.find(params[:market_id])
      render json: VendorSerializer.new(market.vendors)
    rescue ActiveRecord::RecordNotFound => error
      render json: ErrorSerializer.not_found(error), status: :not_found
    end
  end

  def create
    market_vendor = MarketVendor.new(market_vendor_params)
      if market_vendor.save 
        render json: {message: "Successfully added vendor to market"}, status: :created
      elsif params[:market_id].nil? || params[:vendor_id].nil?
        render json: ErrorSerializer.invalid(market_vendor.errors), status: :bad_request
      elsif MarketVendor.find_by(market_vendor_params)
        render json: ErrorSerializer.invalid(market_vendor.errors), status: :unprocessable_entity
      else
        render json: ErrorSerializer.invalid(market_vendor.errors), status: :not_found
      end
  end

  private
  def market_vendor_params
    params.permit(:market_id, :vendor_id)
  end
end