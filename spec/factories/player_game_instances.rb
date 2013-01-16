# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player_game_instance do
    player association(:player)
    game_instance association(:game_instance)
  end
end
