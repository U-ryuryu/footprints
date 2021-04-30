FactoryBot.define do
  factory :client do
    name          { Faker::Name.name }
    tel           { Faker::Number.between(from: 1, to: 99_999_999_999) }
    postal_code   { Faker::Number.number(digits: 7).to_s.insert(3, '-') }
    address       { Faker::Address.street_address }
    charge        { Faker::Name.name }
    charge_tel    { Faker::Number.between(from: 1, to: 99_999_999_999) }
  end
end
