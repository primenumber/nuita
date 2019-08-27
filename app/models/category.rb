class Category < ApplicationRecord
  validates :name, presence: true, length: {maximum: 30}

  has_many :link_categories, dependent: :destroy
  has_many :links, through: :link_categories
end
