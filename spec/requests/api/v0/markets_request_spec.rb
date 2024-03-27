require "rails_helper"

describe "Markets Api" do
    # us-1
    it "sends a list of markets" do 
        create_list(:market, 4)

        get "/api/v0/markets"

        expect(response).to be_successful

        markets = JSON.parse(response.body, symbolize_names: true)
        
        expect(markets[:data].count).to eq(4)
        
        markets[:data].each do |market|

            expect(market[:attributes]).to have_key(:name)
            expect(market[:attributes][:name]).to be_a(String)

            expect(market[:attributes]).to have_key(:street)
            expect(market[:attributes][:street]).to be_a(String)

            expect(market[:attributes]).to have_key(:city)
            expect(market[:attributes][:city]).to be_a(String)

            expect(market[:attributes]).to have_key(:county)
            expect(market[:attributes][:county]).to be_a(String)

            expect(market[:attributes]).to have_key(:state)
            expect(market[:attributes][:state]).to be_an(String)

            expect(market[:attributes]).to have_key(:zip)
            expect(market[:attributes][:zip]).to be_an(String)

            expect(market[:attributes]).to have_key(:lat)
            expect(market[:attributes][:lat]).to be_an(String)

            expect(market[:attributes]).to have_key(:lon)
            expect(market[:attributes][:lon]).to be_an(String)

            expect(market[:attributes]).to have_key(:vendor_count)
            expect(market[:attributes][:vendor_count]).to be_an(Integer)
        end
    end

    # us-2
    it "find market by it's id" do 
        id = create(:market).id 

        get "/api/v0/markets/#{id}"
        
        market = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

        expect(response).to be_successful

        expect(market).to have_key(:name)
        expect(market[:name]).to be_a(String)

        expect(market).to have_key(:street)
        expect(market[:street]).to be_a(String)

        expect(market).to have_key(:city)
        expect(market[:city]).to be_a(String)

        expect(market).to have_key(:county)
        expect(market[:county]).to be_a(String)

        expect(market).to have_key(:state)
        expect(market[:state]).to be_an(String)

        expect(market).to have_key(:zip)
        expect(market[:zip]).to be_an(String)

        expect(market).to have_key(:lat)
        expect(market[:lat]).to be_an(String)

        expect(market).to have_key(:lon)
        expect(market[:lon]).to be_an(String)

        expect(market).to have_key(:vendor_count)
        expect(market[:vendor_count]).to be_an(Integer)
    end

    describe "sad path" do 
        it "errors with an invalid id" do 
            id = 55555 
            headers = {
                "CONTENT_TYPE": "application/json",
                "ACCEPT": "application/json"
            }

            get "/api/v0/markets/#{id}", headers: headers

            expect(response).to_not be_successful

            expect(response.status).to eq(404)
           
            data = JSON.parse(response.body, symbolize_names: true)

            expect(data[:errors]).to be_a(Array)
            expect(data[:errors].first[:status]).to eq(404)
            expect(data[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=55555")
        end
    end
end