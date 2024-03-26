class Api::V0::MarketsController < ApplicationController 
    def index 
        render json: Market.all
    end 

    def show 
        # NEED SAD PATH
        render json: Market.find(params[:id])
    end
end