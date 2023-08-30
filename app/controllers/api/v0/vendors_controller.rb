class Api::V0::VendorsController < ApplicationController
  def show
    begin
      vendor = Vendor.find(params[:id])
      render json: VendorSerializer.new(vendor)
    rescue ActiveRecord::RecordNotFound => error
      render json: ErrorSerializer.format_error(error), status: :not_found
    end
  end
end