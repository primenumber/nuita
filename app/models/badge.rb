class Badge < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: {maximum: 200}
  validates :icon, presence: true

  has_and_belongs_to_many :users
end
