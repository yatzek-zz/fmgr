# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player_game do
    association(:player)
    association(:game)
  end
end
