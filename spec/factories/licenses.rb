FactoryBot.define do
  factory :license do
    key { Faker::Code.nric }
    game_id { :game.id }
    status { :available }
  end
end
