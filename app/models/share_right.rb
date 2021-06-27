class ShareRight < ApplicationRecord
  belongs_to :user
  validates :question, presence: true
  validates :ranking, presence: true
  validates :yes_or_no, presence: true
  validates :text, presence: true
  enum question: { active: 0, inactive: 1 }, _prefix: true
  enum ranking: { active: 0, inactive: 1 }, _prefix: true
  enum yes_or_no: { active: 0, inactive: 1 }, _prefix: true
  enum text: { active: 0, inactive: 1 }, _prefix: true
end
