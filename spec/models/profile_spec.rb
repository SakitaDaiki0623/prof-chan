# == Schema Information
#
# Table name: profiles
#
#  id                 :bigint           not null, primary key
#  user_id            :bigint           not null, foreign_key
#  introduction       :text
#  height             :integer          not null
#  gender             :integer          not null
#  birthday           :datetime         not null
#  day_of_joinning    :datetime         not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)

# spec/models/profile_spec.rb
require 'rails_helper'

RSpec.describe Profile, type: :model do

  it '有効なファクトリを持つこと' do
    expect(build(:profile)).to be_valid
  end

  describe 'validations' do
    it 'heightがなかったら、ユーザー登録に失敗すること' do
      profile = build(:profile, height: nil)
      profile.valid?
      expect(profile.errors[:height]).to include("を入力してください", "は数値で入力してください")
    end

    it 'genderがなかったら、ユーザー登録に失敗すること' do
      profile = build(:profile, gender: nil)
      profile.valid?
      expect(profile.errors[:gender]).to include("を入力してください")
    end

    fit 'prefecture_idがなかったら、ユーザー登録に失敗すること' do
      profile = build(:profile, prefecture_id: nil)
      profile.valid?
      expect(profile.errors[:prefecture_id]).to include("を入力してください")
    end

    it 'blood_typeがなかったら、ユーザー登録に失敗すること' do
      profile = build(:profile, blood_type: nil)
      profile.valid?
      expect(profile.errors[:blood_type]).to include("を入力してください")
    end

    it 'introductionが2000文字より長いなら、ユーザー登録に失敗すること' do
      profile = build(:profile, introduction: 'a' * 2001)
      profile.valid?
      expect(profile.errors[:introduction]).to include("は2000文字以内で入力してください")
    end

    it 'birthdayがなかったら、ユーザー登録に失敗すること' do
      profile = build(:profile, birthday: nil)
      profile.valid?
      expect(profile.errors[:birthday]).to include("を入力してください")
    end

    it 'birthdayが未来の日付なら、ユーザー登録に失敗すること' do
      profile = build(:profile, birthday: Date.tomorrow)
      profile.valid?
      expect(profile.errors[:birthday]).to include("に未来の日付は使えません")
    end

    it 'day_of_joinningがなかったら、ユーザー登録に失敗すること' do
      profile = build(:profile, day_of_joinning: nil)
      profile.valid?
      expect(profile.errors[:day_of_joinning]).to include("を入力してください")
    end
  end
end
