FactoryBot.define do
  factory :message do
    content { Faker::Lorem.characters(number: 500) }
  end
end