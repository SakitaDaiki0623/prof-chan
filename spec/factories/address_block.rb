FactoryBot.define do
  factory :address_block do
    full_address { 'a' * 10 }
    postcode     { 'a' * 10 }
    twitter      { 'a' * 10 }
    instagram    { 'a' * 10 }
    association :profile_block
  end
end
