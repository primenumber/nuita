class NweetLink < ApplicationRecord
  belongs_to :nweet
  belongs_to :link

  validates :nweet_id, presence: true
  validates :link_id, presence: true
end
