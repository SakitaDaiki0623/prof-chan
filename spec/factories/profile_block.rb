# == Schema Information
#
# Table name: profile_blocks
#
#  id                 :bigint           not null, primary key
#  user_id            :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# spec/factories/profile_block.rb
FactoryBot.define do
  factory :profile_block do
    association :user

    after(:create) do |profile_block|
      3.times do
        create(:question_block, profile_block: profile_block)
        create(:ranking_block, profile_block: profile_block)
        create(:text_block, profile_block: profile_block)
        create(:yes_or_no_block, profile_block: profile_block)
      end
    end
  end

end
