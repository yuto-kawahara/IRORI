FactoryBot.define do
  factory :recruit do
    title { Faker::Lorem.characters(number: 200) }
    start_time { Time.current }
    capacity { 1 }
    time_required { 1 }
    discord_server_link { 'server_link' }
  end
end