# == Schema Information
#
# Table name: teams
#
#  id                 :bigint           not null, primary key
#  name               :string(255)      not null
#  image              :string(255)      not null
#  workspace_id       :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# Indexes
#
#  index_teams_on_workspace_id          (workspace_id)

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

    it 'imageがなかったら、ユーザー登録に失敗すること' do
      team = build(:team, image: nil)
      team.valid?
      expect(team.errors[:image]).to include("を入力してください")
    end
  end
end
