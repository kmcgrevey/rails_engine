FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    created_at { "MyString" }
    updated_at { "MyString" }
  end
end
