class Api::V0::MarketsController < ApplicationController 
    def index 
        # require 'pry'; binding.pry
        render json: MarketSerializer.new(Market.all)
    end 

    def show 
        # NEED SAD PATH
        begin 
            market = Market.find(params[:id])
            render json: MarketSerializer.new(market)
        rescue ActiveRecord::RecordNotFound => exception 
            message = ErrorMessage.new(exception.message, 404)
            render json: ErrorSerializer.new(message).serialize_json(params[:id]), status: :not_found
        end 
    end
end