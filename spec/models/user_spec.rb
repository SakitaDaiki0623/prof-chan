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
