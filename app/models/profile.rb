class Profile < ApplicationRecord
  include PublicUidGenerator

  belongs_to :user

  enum gender: { male: 0, female: 1 }
  enum blood_type: { A: 0, B: 1, AB: 2, O: 3 }

  validates :height, presence: true, numericality: true
  validates :gender, presence: true
  validates :prefecture_id, presence: true
  validates :blood_type, presence: true
  validates :birthday, presence: true
  validate  :birthday_cannot_be_in_the_future
  validates :day_of_joinning, presence: true

  scope :by_team, ->(user) { includes(user: :team).where(teams: { workspace_id: User.find(user.id).team.workspace_id }) }
  scope :recently_joined, -> { order(day_of_joinning: :desc).limit(3) }
  scope :filter_by_birth_month, ->(month) { where('extract(month from birthday) = ?', month).order(Arel.sql('extract(day from birthday) ASC')) }

  def birthday_cannot_be_in_the_future
    errors.add(:birthday, 'に未来の日付は使えません') if birthday.present? && birthday > Time.zone.today
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  def to_param
    public_uid
  end
end
