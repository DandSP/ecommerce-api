FactoryBot.define do
  factory :license do
    key { Faker::Code.nric }
    game
    status { :available }
  end
end
