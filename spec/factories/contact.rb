FactoryBot.define do
  factory :contact do
    subject { Faker::Lorem.characters(number: 100) }
    message { Faker::Lorem.characters(number: 1000) }
  end
end