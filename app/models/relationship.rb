class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'
  has_one :notification, dependent: :destroy

  validates :follower_id, presence: true
  validates :followee_id, presence: true

  after_create do
    create_notification(origin_id: follower.id, destination_id: followee.id, action: :follow)
  end
end
