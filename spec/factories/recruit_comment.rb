FactoryBot.define do
  factory :recruit_comment do
    comment { Faker::Lorem.characters(number: 500) }
  end
end