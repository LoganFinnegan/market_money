class Api::V0::MarketVendorsController < ApplicationController

  def create
    market_vendor = MarketVendor.create!(market_vendors_params)
    render json: {message: "Successfully added vendor to market"}, status: :created
  end

  def destroy
    market_vendor = MarketVendor.find_by(market_vendors_params)
    if market_vendor
      market_vendor.destroy
      render json: {message: "Successfully deleted vendor and market relationship"}, status: 204
    else 
      raise ActiveRecord::RecordNotFound.new("Couldn't find Market with 'id'=#{params[:market_id]}")
    end 
  end

  private 

  def market_vendors_params
    params.require(:market_vendor).permit(:market_id, :vendor_id)
  end
end