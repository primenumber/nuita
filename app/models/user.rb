class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         #:confirmable, :lockable, :timeoutable #,
         #:omniauthable, omniauth_providers: [:twitter]

  has_many :nweets, dependent: :destroy

  validates :screen_name, presence: true, uniqueness: true, length: {maximum: 20}
  validates :screen_name, format: {with: /[0-9a-zA-Z_]/}
  validates :handle_name, length: {maximum: 30}
end
