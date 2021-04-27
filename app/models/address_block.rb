class AddressBlock < ApplicationRecord
  # association ==========
  belongs_to :profile_block

  # validation =============
  # TODO: ポストコードの正規表現がうまくいかないので後ほど追記
  # validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}, allow_nil: true

  # scope =============
  scope :by_team, ->(current_user) { includes(profile_block: { user: :team }).where(teams: { workspace_id: User.find(current_user.id).team.workspace_id }) }
end
