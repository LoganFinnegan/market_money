class Vendor < ApplicationRecord
    has_many :market_vendors, dependent: :destroy
    has_many :markets, through: :market_vendors

    validates :name, presence: true
    validates :description, presence: true
    validates :contact_name, presence: true
    validates :contact_phone, presence: true

    validates :credit_accepted, inclusion: [true, false]
    validates :credit_accepted, exclusion: [nil]





    # validates :credit_accepted, inclusion: { in: [ true, false ] } 

    # def credit_accepted_boolean
    #   errors.add(:credit_accepted, "is not active") unless customer.active?
    # end
end