class  Api::V0::MarvendorController < ApplicationController

  def index
    mar_vendors = Market.find(params[:market_id]).vendors
    render json: VendorSerializer.new(mar_vendors)
  end
end