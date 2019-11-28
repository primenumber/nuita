class Badge < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: {maximum: 200}
  validates :icon, presence: true
end
