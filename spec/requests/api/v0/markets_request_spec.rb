require "rails_helper"

describe "Markets Api" do 
    it "sends a list of markets" do 
        create_list(:market, 4)

        get "/api/v0/markets"

        expect(response).to be_successful

        markets = JSON.parse(response.body, symbolize_names: true)

        expect(markets.count).to eq(4)
        
        markets.each do |market|
            expect(market).to have_key(:id)
            expect(market[:id]).to be_an(Integer)

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

            expect(market).to have_key(:vender_count)
            expect(market[:vender_count]).to be_an(Integer)
        end
    end
end