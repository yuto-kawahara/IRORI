FactoryBot.define do
  factory :user do
    nickname { Faker::Lorem.characters(number: 50) }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number: 300) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end