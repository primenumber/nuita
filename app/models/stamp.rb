class Stamp < ApplicationRecord
  enum action: [:nweet, :like]

  belongs_to :user
  has_one :nweet

  validates :action, presence: true
  validates :date, presence: true
end
