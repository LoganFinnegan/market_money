class MarketVendor < ApplicationRecord
    belongs_to :vendor
    belongs_to :market
end