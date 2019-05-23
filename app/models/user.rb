class User < ApplicationRecord
  before_create :set_url_digest

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         #:confirmable, :lockable, :timeoutable #,
         #:omniauthable, omniauth_providers: [:twitter]

  has_many :nweets, dependent: :destroy
  mount_uploader :icon, IconUploader

  validates :screen_name, presence: true, uniqueness: true, length: {maximum: 20}
  validates :screen_name, format: {with: /[0-9a-zA-Z_]/}
  validates :handle_name, length: {maximum: 30}

  # list nweets shown in timeline.
  def timeline
    Nweet.all # currently it is global! (since FF is not implemented)
  end

  class << self
    def screen_name_formatter(str)
      str.gsub(/\W/, '_')[0...20]
    end
  end

  private
    def set_url_digest
      self.url_digest = SecureRandom.urlsafe_base64
    end
end
