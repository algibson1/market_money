class Api::V0::VendorsController < ApplicationController
  before_action :find_vendor, only: [:show, :update]

  def show
    render json: VendorSerializer.new(@vendor)
  end

  def create
    vendor = Vendor.new(vendor_params)
    if vendor.save
      render json: VendorSerializer.new(vendor), status: :created
    else 
      render json: ErrorSerializer.invalid(vendor.errors), status: :bad_request
    end
  end

  def update
    @vendor.update(vendor_params)
    if @vendor.save
      render json: VendorSerializer.new(@vendor)
    else 
      render json: ErrorSerializer.invalid(@vendor.errors), status: :bad_request
    end
  end

  private

  def find_vendor
    begin
      @vendor = Vendor.find(params[:id])
    rescue ActiveRecord::RecordNotFound => error
      render json: ErrorSerializer.not_found(error), status: :not_found
    end
  end

  def vendor_params
    params.permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end