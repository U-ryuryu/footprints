FactoryBot.define do
  factory :visit do
    title       { Faker::Coffee.blend_name }
    date        { Faker::Date.backward }
    content     { Faker::Coffee.notes }
    status_id   { Faker::Number.between(from: 2, to: 5) }
    association :user
    association :client
  end
end
