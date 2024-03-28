require 'rails_helper'

describe 'vendor update' do
  it 'can update a vendors attributes' do 
    vendor =create(:vendor)
    id = vendor.id

    headers = {
      "CONTENT_TYPE": "application/json",
      "ACCEPT": "application/json"
    }

    vendor_params = {
      name: "Buzzy Bees",
      description: "local honey and wax products",
      contact_name: "Kimberly Couwer",
      contact_phone: "8389928383",
      credit_accepted: false
    }

    patch "/api/v0/vendors/#{id}", params: vendor_params.to_json, headers: headers

    vendor = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    check_hash_structure(vendor, :name, String)
    check_hash_structure(vendor, :description, String)
    check_hash_structure(vendor, :contact_name, String)
    expect(vendor[:contact_name]).to eq("Kimberly Couwer")
    check_hash_structure(vendor, :contact_phone, String)
    check_hash_structure(vendor, :credit_accepted, FalseClass)
  end

  describe "sad path" do 
    it "has a invade id for vendor" do 
      id = 5555
  
      headers = {
        "CONTENT_TYPE": "application/json",
        "ACCEPT": "application/json"
      }
  
      patch "/api/v0/vendors/#{id}", headers: headers

      expect(response).to_not be_successful

      expect(response.status).to eq(404)
  
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Couldn't find Vendor with 'id'=5555")
  
    end

    it "cant have blank attributes" do 
      vendor =create(:vendor)
      id = vendor.id
  
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
  
      patch "/api/v0/vendors/#{id}", params: vendor_params.to_json, headers: headers

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Validation failed: Contact name can't be blank, Contact phone can't be blank")
    end
  end
end
