class Stamp < ApplicationRecord
  enum action: [:nweet, :like]

  belongs_to :user
  belongs_to :nweet
  belongs_to :like, optional: true

  validates :action, presence: true
  validates :targeted_at, presence: true
end
