FactoryBot.define do
  factory :invoice do
    customer
    merchant
    status { "shipped" }
    created_at { "MyString" }
    updated_at { "MyString" }
  end
end
