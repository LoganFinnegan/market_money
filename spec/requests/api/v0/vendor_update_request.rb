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
    xit "has a invade id for vendor" do 
      vendor =create(:vendor)
      id = vendor.id
  bui
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
  
    end

    xit "cant have blank attributes" do 
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
    end
  end
end
