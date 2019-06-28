class Favorite < ApplicationRecord
  belongs_to :nweet
  belongs_to :user
  validates_uniqueness_of :nweet_id, scope: :user_id
end
