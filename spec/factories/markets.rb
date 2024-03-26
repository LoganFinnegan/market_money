FactoryBot.define do
  factory :market do
    name { Faker::FunnyName.name }
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    county { Faker::Address.country }
    state { Faker::Address.state }
    zip { Faker::Address.zip }
    lat { Faker::Address.longitude }
    lon { Faker::Address.latitude }
    vender_count { 0 } 
  end
end
