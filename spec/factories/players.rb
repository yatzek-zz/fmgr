
FactoryGirl.define do
  factory :messi, class: Player do
    name 'Leo'
    surname 'Messi'
    sequence(:email) {|i| "leo.messi#{i}@example.com" }
  end

  factory :iniesta, class: Player do
    name 'Anders'
    surname 'Iniesta'
    sequence(:email) {|i| "anders.iniesta#{i}@example.com" }
  end

  factory :szlachta, class: Player do
    name 'Jacek'
    surname 'Szlachta'
    email 'jacek.szlachta@gmail.com'
  end
end