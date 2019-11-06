class Preference < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :user, presence: true
  validates :category, presence: true

  # User can have multiple Prefences which express different meanings. (e.g. mute list and block list)
  # Therefore, a pair of user and category doesn't have to be unique.
  # validates_uniqueness_of :user_id, scope: :category_id
end
