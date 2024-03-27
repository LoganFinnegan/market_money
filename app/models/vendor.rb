class Vendor < ApplicationRecord
    has_many :market_vendors, dependent: :destroy
    has_many :markets, through: :market_vendors
end