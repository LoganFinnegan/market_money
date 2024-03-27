class Market < ApplicationRecord
    has_many :market_vendors, dependent: :destroy
    has_many :vendors, through: :market_vendors

    def vendor_count
        # require 'pry'; binding.pry
        self.vendors.count
    end
end
