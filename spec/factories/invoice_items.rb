FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { 1 }
    unit_price { Faker::Number.positive }
    created_at { "MyString" }
    updated_at { "MyString" }
  end
end
