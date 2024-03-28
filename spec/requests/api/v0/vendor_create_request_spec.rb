require 'rails_helper'

describe 'create vendor' do
  it 'can create a new vendor' do 

    headers = {
      "CONTENT_TYPE": "application/json",
      "ACCEPT": "application/json"
    }

    vendor_params = {
      name: "Buzzy Bees",
      description: "local honey and wax products",
      contact_name: "Berly Couwer",
      contact_phone: "8389928383",
      credit_accepted: false
    }

    post '/api/v0/vendors', params: vendor_params.to_json, headers: headers

    vendor = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    check_hash_structure(vendor, :name, String)
    check_hash_structure(vendor, :description, String)
    check_hash_structure(vendor, :contact_name, String)
    check_hash_structure(vendor, :contact_phone, String)
    check_hash_structure(vendor, :credit_accepted, FalseClass)
  end

  describe "sad path" do 
    it "errors on missing attributes" do 

      headers = {
        "CONTENT_TYPE": "application/json",
        "ACCEPT": "application/json"
      }
  
      vendor_params = {
        name: "Buzzy Bees",
        description: "local honey and wax products",
        contact_name: "",
        contact_phone: "",
        credit_accepted: false
      }
  
      post '/api/v0/vendors', params: JSON.generate(vendor: vendor_params), headers: headers

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Validation failed: Contact name can't be blank, Contact phone can't be blank")
    end
  end
end
