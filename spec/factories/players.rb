
FactoryGirl.define do
  factory :player do
    name 'Leo'
    surname 'Messi'
    sequence(:email) {|i| "leo.messi#{i}@example.com" }
  end
end