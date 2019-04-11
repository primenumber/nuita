class Nweet < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :did_at, presence: true
  validate :did_at_past?

  default_scope -> { order(did_at: :desc) }

  def did_at_past?
    if did_at # did at is not nil
      errors.add(:did_at, "is not in the past") unless did_at <= Time.zone.now
    end
  end
end
