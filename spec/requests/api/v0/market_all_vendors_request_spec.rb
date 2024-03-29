require "rails_helper"
 
describe "Markets Api" do
  # us-3 
  it "shows all vendors for a market" do 
    market = create(:market)
    vendor = create(:vendor)
    vendor_2 = create(:vendor)
    vendor_3 = create(:vendor)
    mv1 = MarketVendor.create!(market_id: market.id, vendor_id: vendor.id)
    mv2 = MarketVendor.create!(market_id: market.id, vendor_id: vendor_2.id)
    mv3 = MarketVendor.create!(market_id: market.id, vendor_id: vendor_3.id)

    id = market.id
    
    headers = {
            "CONTENT_TYPE": "application/json",
            "ACCEPT": "application/json"
        }

    get "/api/v0/markets/#{id}/vendors", headers: headers

    market_parsed = JSON.parse(response.body, symbolize_names: true)[:data]

    vendor = market_parsed.first[:attributes]

    check_hash_structure(vendor, :name, String)
    check_hash_structure(vendor, :description, String)
    check_hash_structure(vendor, :contact_name, String)
    check_hash_structure(vendor, :contact_phone, String)
    check_hash_structure(vendor, :credit_accepted, TrueClass)
  end

  describe "sad path" do 
    it "errors on an invalid id" do 
      id = 5555
      
      headers = {
              "CONTENT_TYPE": "application/json",
              "ACCEPT": "application/json"
          }

      get "/api/v0/markets/#{id}/vendors", headers: headers
      
      expect(response).to_not be_successful

      expect(response.status).to eq(404)
  
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=5555")
    end
  end
end