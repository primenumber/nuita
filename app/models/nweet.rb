class Nweet < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :did_at, presence: true
  validates :statement, length: {maximum: 100}
  validate :did_at_past?
  validate :have_enough_interval?, on: :create

  default_scope -> { order(did_at: :desc) }

  def did_at_past?
    if did_at # did at is not nil
      errors.add(:did_at, " is not in the past") unless did_at <= Time.zone.now
    end
  end

  # may need refactoring
  def have_enough_interval?
    if user.nweets.count != 0 && did_at && did_at < user.nweets.first.did_at + 3.minutes
      errors.add(:did_at, " has not enough interval")
    end
  end

  def create
  end

  def to_param
    url_digest
  end
end
