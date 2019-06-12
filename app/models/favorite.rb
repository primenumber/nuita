class Favorite < ApplicationRecord
  belongs_to :nweet
  belongs_to :user
end
