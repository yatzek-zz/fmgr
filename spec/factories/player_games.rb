FactoryGirl.define do

  factory :player_game do
    association(:player)
    association(:game)
  end

end
