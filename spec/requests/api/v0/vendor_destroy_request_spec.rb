require 'rails_helper'

describe 'destory vendor' do
  it 'delete a vendor' do 
    vendor =create(:vendor)
    id = vendor.id

    expect(Vendor.count).to eq(1)
    
    delete "/api/v0/vendors/#{id}"
    
    expect(response).to be_successful
    expect(Vendor.count).to eq(0)
  end

  describe 'sad path' do 
    it 'failed to delete the vendor' do 
      id = 5555
  
      headers = {
        "CONTENT_TYPE": "application/json",
        "ACCEPT": "application/json"
      }
  
      delete "/api/v0/vendors/#{id}"
      
      expect(response).to_not be_successful

      expect(response.status).to eq(404)
  
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Couldn't find Vendor with 'id'=5555")
  
    end
  end
end