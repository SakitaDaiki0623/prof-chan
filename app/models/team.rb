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
#  index_users_on_workspace_id          (workspace_id)

# app/models/team.rb
class Team < ApplicationRecord
  # association ==========
  has_many :users, dependent: :destroy

  #  validation ==========
  validates :name, presence: true
  validates :workspace_id,     presence: true, uniqueness: { case_sensitive: true }
  validates :share_channel_id, presence: true, uniqueness: { case_sensitive: true }
  validates :image, presence: true
end
