require "rails_helper"

RSpec.describe MarketVendor, type: :model do
  describe "validations" do
    it { should validate_presence_of :market_id }
    it { should validate_presence_of :vendor_id }
  end

  describe "relationships" do
    it {should belong_to :vendor}
    it {should belong_to :market}
  end
end