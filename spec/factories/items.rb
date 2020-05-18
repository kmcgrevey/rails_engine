FactoryBot.define do
  factory :item do
    name { Faker::Appliance.equipment }
    description { Faker::ChuckNorris.fact }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    merchant { nil }
  end
end
