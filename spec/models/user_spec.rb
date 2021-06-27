require 'rails_helper'

RSpec.describe User, type: :model do

  it '有効なファクトリを持つこと' do
    expect(create(:user)).to be_valid
  end

  describe 'validations' do
    it 'nameがなかったら、ユーザー登録に失敗すること' do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it 'emailがなかったら、ユーザー登録に失敗すること' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it 'team_idがなかったら、ユーザー登録に失敗すること' do
      user = build(:user, team_id: nil)
      user.valid?
      expect(user.errors[:team]).to include("を入力してください")
    end

    it 'providerがなかったら、ユーザー登録に失敗すること' do
      user = build(:user, provider: nil)
      user.valid?
      expect(user.errors[:provider]).to include("を入力してください")
    end

    it 'passwordがなかったら、ユーザー登録に失敗すること' do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:encrypted_password]).to include("を入力してください")
    end
  end
end
