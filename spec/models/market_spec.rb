require "rails_helper"

RSpec.describe Market, type: :model do
  # describe "validations" do
  #   it { should validate_presence_of :}
  #   it { should validate_numericality_of :}
  #   it { should define_enum_for(:).with_values(:)}
  # end

  describe "relationships" do
    it { should have_many :market_vendors } 
    it { should have_many(:vendors).through(:market_vendors) }
  end

  describe "instance methods" do 
    describe "#vendor_count" do 
      it "counts vendors for a market" do 
        market = create(:market)
        market_2 = create(:market)
        vendor = create(:vendor)
        vendor_2 = create(:vendor)

        mv1 = MarketVendor.create!(market_id: market.id, vendor_id: vendor.id)
        mv2 = MarketVendor.create!(market_id: market_2.id, vendor_id: vendor_2.id)

        expect(market.vendor_count).to eq(1)
        expect(market_2.vendor_count).to eq(1)
      end
    end
  end
end
