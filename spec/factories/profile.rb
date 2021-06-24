FactoryBot.define do
  factory :profile do
    height { rand(130..210) }
    gender { rand(0..1) }
    prefecture_id { rand(1..47) }
    blood_type { 'AB' }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
    day_of_joinning { Faker::Date.between(from: 20.years.ago, to: 1.years.from_now) }
    association :user

    trait :my_profile do
      height { 168 }
      gender { 0 }
      prefecture_id { 22 }
      blood_type { 'O' }
      birthday { Date.new(1996, 6, 23) }
      day_of_joinning { Date.new(2020, 4, 1) }
    end
  end
end
