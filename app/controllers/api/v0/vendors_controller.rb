class Api::V0::VendorsController < ApplicationController
  before_action :find_vendor, only: [:show, :update, :destroy]

  def show
    render json: VendorSerializer.new(@vendor)
  end

  def create
    vendor = Vendor.new(vendor_params)
    if ["true", "false"].include?(params[:credit_accepted]) && vendor.save
      render json: VendorSerializer.new(vendor), status: :created
    elsif !["true", "false"].include?(params[:credit_accepted])
      vendor = Vendor.create(vendor_params_nix_credit_accepted)
      render json: ErrorSerializer.invalid(vendor.errors), status: :bad_request
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

  def destroy
    @vendor.destroy
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

  def vendor_params_nix_credit_accepted
    params.permit(:name, :description, :contact_name, :contact_phone)
  end
end