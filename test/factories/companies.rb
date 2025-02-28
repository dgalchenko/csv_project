FactoryBot.define do
  factory :company do
    registry_number { Faker::Number.number(digits: 10).to_s }
    name { Faker::Company.name }
    city { Faker::Address.city }
  end
end