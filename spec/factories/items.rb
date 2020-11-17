FactoryBot.define do
  factory :item do
    name { Faker::Appliance.equipment }
    description { Faker::ChuckNorris.fact }
    unit_price { Faker::Number.positive }
    merchant
  end
end
