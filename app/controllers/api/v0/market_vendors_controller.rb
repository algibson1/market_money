class Api::V0::MarketVendorsController < ApplicationController
  before_action :validate_params_presence, only: [:create]
  before_action :validate_association, only: [:destroy]

  def index
    market = Market.find(params[:market_id])
    render json: VendorSerializer.new(market.vendors)
  end

  def create
    market_vendor = MarketVendor.create!(market_vendor_params)
    render json: {message: "Successfully added vendor to market"}, status: :created
  end

  def destroy
    market_vendor = MarketVendor.find_by!(market_vendor_params)
    market_vendor.delete
  end

  private
  def market_vendor_params
    params.permit(:market_id, :vendor_id)
  end

  def validate_params_presence
    if params[:market_id].nil? || params[:vendor_id].nil?
      raise ActionController::BadRequest.new(), "Validation failed: Need both a market and a vendor id"
    end
  end

  def validate_association 
    if MarketVendor.find_by(market_vendor_params).nil?
      raise ActiveRecord::RecordNotFound.new(), "No association exists between market with 'id'=#{params[:market_id]} AND vendor with 'id'=#{params[:vendor_id]}"
    end
  end
end