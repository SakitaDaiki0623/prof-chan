# == Schema Information
#
# Table name: yes_or_no_blocks
#
#  id                 :bigint           not null, primary key
#  title              :string(255)      not null
#  profile_block_id   :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# spec/factories/yes_or_no_block_blocks.rb
FactoryBot.define do
  factory :yes_or_no_block do
    title { Faker::Lorem.characters(number: 30) }
    association :profile_block
    after(:create) do |yes_or_no_block|
      [1, 2, 3].sample.times do
        create(:yes_or_no_item, yes_or_no_block: yes_or_no_block)
      end
    end
  end
end
