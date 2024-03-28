class Api::V0::VendorsController < ApplicationController
  
  def show 
    vendor = Vendor.find(params[:id])
    render json: VendorSerializer.new(vendor)
  end

  def create
    vendor = Vendor.create!(vendor_params)
    render json: VendorSerializer.new(vendor), status: :created
  end

  def update
    vendor = Vendor.find(params[:id])
    vendor.update!(vendor_params)
    render json: VendorSerializer.new(vendor)
  end

  def update
    vendor = Vendor.find(params[:id])
    vendor.update!(vendor_params)
    render json: VendorSerializer.new(vendor)
  end

  def destroy
    vendor = Vendor.find(params[:id])
    vendor.destroy
    # # require 'pry'; binding.pry
    # Vendor.destroy(params[:id])
    # # status here for 200 code
    # begin 
    #   Vendor.find(params[:id])
    # rescue ActiveRecord::RecordNotFound => exception
    #   render json: ErrorSerializer.new(exception), status: :not_found
    # end 
  end
  private 

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end

