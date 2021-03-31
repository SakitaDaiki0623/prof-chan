class Team < ApplicationRecord
  has_many :users, dependent: :destroy

  validates :name, presence: true
  validates :workspace_id, presence: true, uniqueness: { case_sensitive: true }
  validates :image, presence: true
end
