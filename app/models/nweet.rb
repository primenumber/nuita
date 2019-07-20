require 'uri'

class Nweet < ApplicationRecord
  before_create :set_url_digest
  after_save :create_link

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :fav_users, through: :favorites, source: :user

  has_many :nweet_links, dependent: :destroy
  has_many :links, through: :nweet_links

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

  def create_link
    if self.statement
      URI.extract(self.statement, ['http', 'https']).uniq.each do |url|
        if l = Link.find_by(url: url)
          self.links << l
          l.refetch
        else
          self.links.create(url: url)
        end
      end
    end
  end

  private
    def set_url_digest
      self.url_digest = SecureRandom.alphanumeric
    end
end
