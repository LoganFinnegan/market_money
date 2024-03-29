class Api::V0::MarketVendorsController < ApplicationController

    def create
        market = Market.find(params[:market_id])
        vendor = Vendor.find(params[:vendor_id])
        MarketVendor.create(market_id: market.id, vendor_id: vendor.id)
        render json: {message: "Successfully added vendor to market"}, status: :created
    end

    private 

    def market_vendors_params
        params.require(:market_vendor).permit(:market_id, :vendor_id)
    end
end