require "rails_helper"

describe "create a market vendor relation" do
  #us-8 
  it "creates a vendor that sells at a market" do 
    market = create(:market)
    vendor = create(:vendor)

    market_vendors_params = {
                                market_id: market.id, 
                                vendor_id: vendor.id
                            }

    headers = {
                "CONTENT_TYPE": "application/json",
                "ACCEPT": "application/json"
            }

    post "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor: market_vendors_params)

    market_vendor = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful
    expect(response.status).to eq(201)

    expect(market_vendor).to be_a(Hash)
    expect(market_vendor[:message]).to eq("Successfully added vendor to market")
  end

  describe "sad path" do 
    it "404 error" do 
      vendor = create(:vendor)

      market_vendors_params = {
                                  market_id: 5555, 
                                  vendor_id: vendor.id
                              }

      headers = {
                  "CONTENT_TYPE": "application/json",
                  "ACCEPT": "application/json"
              }

      post "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendors_params)
      
      expect(response).to_not be_successful

      expect(response.status).to eq(404)
  
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Validation failed: Market must exist")
    end 

    it "422 error" do 
      market = create(:market)
      vendor = create(:vendor)
      market_vendor = MarketVendor.create!(vendor_id: vendor.id, market_id: market.id)
  
      market_vendor_params = {
        market_id: market.id,
        vendor_id: vendor.id
      }

      headers = {
              "CONTENT_TYPE": "application/json",
              "ACCEPT": "application/json"
          }
  
      post "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

      expect(response).not_to be_successful
      expect(response.status).to eq(422)
  
      response_data = JSON.parse(response.body, symbolize_names: true)
  
      expect(response_data).to have_key(:errors)
      expect(response_data[:errors]).to be_a(Array)
      expect(response_data[:errors].first).to have_key(:detail)
      expect(response_data[:errors].first[:detail]).to eq("Validation failed: Market has already been taken")
    end
  end
end