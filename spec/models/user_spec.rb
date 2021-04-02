# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  name               :string(255)      default(""), not null
#  email              :string(255)      not null, unique: true
#  provider           :string(255)      default(""), not null
#  uid                :string(255)      not null, unique: true
#  image              :string(255)
#  team_id            :string(255)      not null
#  encrypted_password :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  slack_credential_token  :string(255)     not null
#  reset_password_token    :string(255)
#  reset_password_sent_at  :string(255)
#  remember_created_at     :string(255)
#
# Indexes
#
#  index_users_on_email                    (email)
#  index_users_on_reset_password_token     (reset_password_token)

require 'rails_helper'

RSpec.describe User, type: :model do

  it '有効なファクトリを持つこと' do
    expect(create(:user)).to be_valid
  end

  describe 'validations' do
    it 'nameがなかったら、ユーザー登録に失敗すること' do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("は1文字以上で入力してください", "を入力してください")
    end

    it 'emailがなかったら、ユーザー登録に失敗すること' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it 'emailが重複する時ユーザー登録に失敗すること' do
      user1 = create(:user)
      user2 = build(:user)
      user2.email = user1.email
      user2.valid?
      expect(user2.errors[:email]).to include("はすでに存在します")
    end

    it 'team_idがなかったら、ユーザー登録に失敗すること' do
      user = build(:user, team_id: nil)
      user.valid?
      expect(user.errors[:team_id]).to include("を入力してください")
    end

    it 'uidがなかったら、ユーザー登録に失敗すること' do
      user = build(:user, uid: nil)
      user.valid?
      expect(user.errors[:uid]).to include("を入力してください")
    end

    it 'uidが重複する時ユーザー登録に失敗すること' do
      user1 = create(:user)
      user2 = build(:user)
      user2.uid = user1.uid
      user2.valid?
      expect(user2.errors[:uid]).to include("はすでに存在します")
    end

    it 'slack_credential_tokenがなかったら、ユーザー登録に失敗すること' do
      user = build(:user, slack_credential_token: nil)
      user.valid?
      expect(user.errors[:slack_credential_token]).to include("を入力してください")
    end

    it 'providerがなかったら、ユーザー登録に失敗すること' do
      user = build(:user, provider: nil)
      user.valid?
      expect(user.errors[:provider]).to include("を入力してください")
    end

    it 'passwordがなかったら、ユーザー登録に失敗すること' do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end
  end
end
