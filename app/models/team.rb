class Team < ApplicationRecord
  has_many :users, dependent: :destroy

  validates :name, presence: true
  validates :workspace_id,     presence: true, uniqueness: { case_sensitive: true }
  validates :share_channel_id, presence: true, uniqueness: { scope: [:workspace_id], case_sensitive: true }
  validates :domain, presence: true
  validates :share_channel_name, presence: true
  validates :image, presence: true
  validates :share_right, presence: true

  enum share_right: { active: 0, inactive: 1 }, _prefix: true
end
