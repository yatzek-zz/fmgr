
FactoryGirl.define do
  factory :game_instance do
    association :game_definition
    time Time.now
  end
end
