require 'rails_helper'

  describe 'delete MarketVendor' do
    it 'deletes a joins table' do 

      market = create(:market)
      vendor = create(:vendor)
      market_vendor = MarketVendor.create(market_id: market.id, vendor_id: vendor.id)
      id = market_vendor.id

      market_vendors_params = {
                                market_id: market.id, 
                                vendor_id: vendor.id
                              }

      headers = {
                  "CONTENT_TYPE": "application/json",
                  "ACCEPT": "application/json"
                }

      expect(MarketVendor.count).to eq(1)

      delete "/api/v0/market_vendors/#{id}", headers: headers, params: JSON.generate(market_vendors_params)

      expect(response).to be_successful
      expect(MarketVendor.count).to eq(0)
    end

    describe 'sad path' do 
      it 'cant find the market vendor' do 

      market = create(:market)
      vendor = create(:vendor)
      market_vendor = MarketVendor.create(market_id: market.id, vendor_id: vendor.id)
      id = market_vendor.id

      market_vendors_params = {
                                market_id: 5555, 
                                vendor_id: vendor.id
                              }

      headers = {
                  "CONTENT_TYPE": "application/json",
                  "ACCEPT": "application/json"
                }

      delete "/api/v0/market_vendors/#{id}", headers: headers, params: JSON.generate(market_vendors_params)

      expect(response).to_not be_successful

      expect(response.status).to eq(404)
  
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=5555")
  
      end
    end
  end

 