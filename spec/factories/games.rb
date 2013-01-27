
FactoryGirl.define do
  factory :game do
    association :game_definition
    time Time.now
    emails_sent false
  end
end
