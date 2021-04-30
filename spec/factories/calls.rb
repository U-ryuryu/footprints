FactoryBot.define do
  factory :call do
    title       { Faker::Coffee.blend_name }
    date        { Faker::Time.backward(days: 14, period: :evening) }
    content     { Faker::Coffee.notes }
    status_id   { Faker::Number.between(from: 2, to: 5) }
    association :user
    association :client
  end
end
