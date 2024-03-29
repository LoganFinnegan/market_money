require 'rails_helper'

describe 'Vendor api' do
  it " shows the vendor" do 
    id = create(:vendor).id

    headers = {
      "CONTENT_TYPE": "application/json",
      "ACCEPT": "application/json"
    }
    
    get "/api/v0/vendors/#{id}", headers: headers
    
    vendor = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    check_hash_structure(vendor, :name, String)
    check_hash_structure(vendor, :description, String)
    check_hash_structure(vendor, :contact_name, String)
    check_hash_structure(vendor, :contact_phone, String)
    check_hash_structure(vendor, :credit_accepted, TrueClass)
  end

  describe "sad path" do 
    it "errors on ivalid id" do 
      id = 5555

      headers = {
                    "CONTENT_TYPE": "application/json",
                    "ACCEPT": "application/json"
                }

      get "/api/v0/vendors/#{id}", headers: headers

      expect(response).to_not be_successful

      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Couldn't find Vendor with 'id'=5555")
    end
  end
end