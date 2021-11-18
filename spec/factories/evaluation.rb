FactoryBot.define do
  factory :evaluation do
    stars { Faker::Lorem.characters(number: 1) }
    comment { Faker::Lorem.characters(number: 500) }
  end
end