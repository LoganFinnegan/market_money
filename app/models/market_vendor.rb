class MarketVendor < ApplicationRecord
    belongs_to :vendor
    belongs_to :market

    validates_presence_of :market_id, :vendor_id
    validates_uniqueness_of :market_id, scope: :vendor_id
end