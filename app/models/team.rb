# app/models/team.rb
class Team < ApplicationRecord
  # association ==========
  has_many :users, dependent: :destroy

  #  validation ==========
  validates :name, presence: true
  validates :workspace_id, presence: true, uniqueness: { case_sensitive: true }
  validates :image, presence: true
end
