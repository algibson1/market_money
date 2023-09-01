class Api::V0::VendorsController < ApplicationController
  before_action :find_vendor, only: [:show, :update, :destroy]
  before_action :validate_credit_accepted, only: [:create, :update]

  def show
    render json: VendorSerializer.new(@vendor)
  end

  def create
    vendor = Vendor.create!(vendor_params)
    render json: VendorSerializer.new(vendor), status: :created
  end

  def update
    @vendor.update!(vendor_params)
    render json: VendorSerializer.new(@vendor)
  end

  def destroy
    @vendor.destroy
  end

  private

  def find_vendor
    @vendor = Vendor.find(params[:id])
  end

  def vendor_params
    params.permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end

  def validate_credit_accepted 
    if !["true", "false", true, false].include?(params[:credit_accepted]) && !params[:credit_accepted].nil?
      raise ActionController::BadRequest.new(), "Credit accepted must be true or false"
    end
  end
end