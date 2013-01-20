
FactoryGirl.define do
  factory :game_instance do
    association :game_definition
    time Time.now
    emails_sent false
  end
end
