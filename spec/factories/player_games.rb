# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player_game do
    player association(:player)
    game association(:game)
  end
end
