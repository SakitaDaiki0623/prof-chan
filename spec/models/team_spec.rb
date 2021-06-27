require 'rails_helper'

RSpec.describe Team, type: :model do
  it '有効なファクトリを持つこと' do
    expect(create(:team)).to be_valid
  end

  describe 'validations' do
    it 'nameがなかったら、ユーザー登録に失敗すること' do
      team = build(:team, name: nil)
      team.valid?
      expect(team.errors[:name]).to include("を入力してください")
    end

    it 'workspace_idがなかったら、ユーザー登録に失敗すること' do
      team = build(:team, workspace_id: nil)
      team.valid?
      expect(team.errors[:workspace_id]).to include("を入力してください")
    end

    it 'workspace_idが重複する時ユーザー登録に失敗すること' do
      team1 = create(:team)
      team2 = build(:team)
      team2.workspace_id = team1.workspace_id
      team2.valid?
      expect(team2.errors[:workspace_id]).to include("はすでに存在します")
    end

    it 'share_channel_idがなかったら、ユーザー登録に失敗すること' do
      team = build(:team, share_channel_id: nil)
      team.valid?
      expect(team.errors[:share_channel_id]).to include("を入力してください")
    end

    it 'share_channel_nameがなかったら、ユーザー登録に失敗すること' do
      team = build(:team, share_channel_name: nil)
      team.valid?
      expect(team.errors[:share_channel_name]).to include("を入力してください")
    end

    it 'domainがなかったら、ユーザー登録に失敗すること' do
      team = build(:team, domain: nil)
      team.valid?
      expect(team.errors[:domain]).to include("を入力してください")
    end

    it 'imageがなかったら、ユーザー登録に失敗すること' do
      team = build(:team, image: nil)
      team.valid?
      expect(team.errors[:image]).to include("を入力してください")
    end
  end
end
