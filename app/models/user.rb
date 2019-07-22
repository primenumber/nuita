class User < ApplicationRecord
  before_create :set_url_digest

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         #:confirmable, :lockable, :timeoutable #,
         #:omniauthable, omniauth_providers: [:twitter]

  has_many :nweets, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fav_nweets, through: :favorites, source: :nweet
  mount_uploader :icon, IconUploader

  validates :screen_name, presence: true, uniqueness: true, length: {maximum: 20}
  validates :screen_name, format: {with: /[0-9a-zA-Z_]/}
  validates :handle_name, length: {maximum: 30}

  # list nweets shown in timeline.
  def timeline
    Nweet.all # currently it is global! (since FF is not implemented)
  end

  def to_param
    url_digest
  end

  def add_twitter_account(auth)
    self.update_attributes(
      twitter_url: auth.info.urls.Twitter,
      twitter_uid: auth.uid,
      twitter_screen_name: auth.info.nickname,
      twitter_access_token: auth.credentials.token,
      twitter_access_secret: auth.credentials.secret
    )
  end

  def delete_twitter_account
    self.update_attributes(
      twitter_url: nil,
      twitter_uid: nil,
      twitter_screen_name: nil,
      twitter_access_token: nil,
      twitter_access_secret: nil,
      autotweet_enabled: false
    )
  end

  def tweet(content)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.credentials.twitter[:api_key]
      config.consumer_secret = Rails.application.credentials.twitter[:api_secret]
      config.access_token = self.twitter_access_token
      config.access_token_secret = self.twitter_access_secret
    end

    client.update(content)
  end

  def faved?(nweet)
    self.favorites.exists?(nweet_id: nweet.id)
  end

  class << self
    def screen_name_formatter(str)
      str.gsub(/\W/, '_')[0...20]
    end
  end

  private
    def set_url_digest
      self.url_digest = SecureRandom.alphanumeric
    end
end
